import 'dart:io';
import 'dart:typed_data';

import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcodepro/src/constants/enums.dart';
import 'package:qrcodepro/src/features/database/hive_models.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WifiDataAdapter());
  Hive.registerAdapter(ContactDataAdapter());
  Hive.registerAdapter(SMSDataAdapter());
  Hive.registerAdapter(EmailDataAdapter());
  Hive.registerAdapter(MyContactCardDataAdapter());
  Hive.registerAdapter(GenericQRCodeDataAdapter());
  Hive.registerAdapter(WebsiteDataAdapter());
  Hive.registerAdapter(MobileNumberDataAdapter());
}

Future<void> saveQRCodeData(
    QRCodeData data, QrCodeDataStoreType storeType) async {
  final box = await Hive.openBox<QRCodeData>(
      storeType == QrCodeDataStoreType.scanned
          ? 'qrcodesScannedData'
          : 'qrcodesCreatedData');
  await box.add(data);
}

Future<List<QRCodeData>> getQRCodeData(QrCodeDataStoreType storeType) async {
  final box = await Hive.openBox<QRCodeData>(
      storeType == QrCodeDataStoreType.scanned
          ? 'qrcodesScannedData'
          : 'qrcodesCreatedData');
  final dataList = box.values.toList();
  return dataList;
}

Future<String> storeQrCodeImage(Uint8List imageData) async {
  // Get the application documents directory
  final appDocumentsDirectory = await getApplicationDocumentsDirectory();

  // Create the "qrcode_images" folder if it doesn't exist
  final qrcodeImagesFolder = '${appDocumentsDirectory.path}/qrcode_images';
  await Directory(qrcodeImagesFolder).create(recursive: true);

  // Generate a unique filename
  final filename = 'qrcode_image_${DateTime.now().millisecondsSinceEpoch}.jpg';

  // Create the file path
  final filePath = '$qrcodeImagesFolder/$filename';

  // Save the image to the file
  await File(filePath).writeAsBytes(imageData);

  return filePath;
}

QRCodeData generateQRCodeData({required String qrCodeText}) {
  switch (qrCodeText.substring(0, 7)) {
    case 'WIFI:T:':
      // Parse Wifi data
      final parts = qrCodeText.split(';');
      final ssid = parts[1].split(':')[1];
      final password = parts[2].split(':')[1];
      final securityType =
          WifiSecurityType.values.byName(parts[3].split(':')[1]);
      return WifiData(
          ssid: ssid, password: password, securityType: securityType);
    case 'MECARD:':
      // Parse Contact or MyContactCard data
      final List<String> fields = qrCodeText.split(';');
      final name =
          fields.firstWhere((field) => field.startsWith('N:')).substring(2);
      final phoneNumber =
          fields.firstWhere((field) => field.startsWith('TEL:')).substring(4);
      final email =
          fields.firstWhere((field) => field.startsWith('EMAIL:')).substring(6);
      final address =
          fields.firstWhere((field) => field.startsWith('ADR:')).substring(4);
      final birthDate =
          fields.firstWhere((field) => field.startsWith('BD:')).substring(3);
      final organization =
          fields.firstWhere((field) => field.startsWith('ORG:')).substring(4);
      if (address.isNotEmpty ||
          birthDate.isNotEmpty ||
          organization.isNotEmpty) {
        return MyContactCardData(
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            birthDate: birthDate,
            organization: organization);
      } else {
        return ContactData(name: name, phoneNumber: phoneNumber, email: email);
      }
    case 'SMSTO:':
      // Parse SMS data
      final phoneNumber = qrCodeText.substring(6);
      return SMSData(
          phoneNumber: phoneNumber, msgBody: ''); // Body might not be included
    case 'mailto:':
      // Parse Email data
      final email = qrCodeText.substring(7);
      return EmailData(
          email: email,
          subject: '',
          content: ''); // Subject and content might not be included
    case 'http://':
    case 'https://':
      // Parse Website data
      return WebsiteData(url: qrCodeText);
    case 'tel:':
      // Parse Mobile number data
      final number = qrCodeText.substring(4);
      return MobileNumberData(number: number);
    default:
      // Generic data type (no specific format detected)
      return GenericQRCodeData(value: qrCodeText);
  }
}

String generateQRCodeText({required QRCodeData qrCodeData}) {
  switch (qrCodeData.type) {
    case 'wifi':
      final WifiData wifiData = qrCodeData as WifiData;
      return 'WIFI:T:WPA;S:${wifiData.ssid};P:${wifiData.password};H:false;';
    case 'contact':
      final ContactData contactData = qrCodeData as ContactData;
      return 'MECARD:N:${contactData.name};TEL:${contactData.phoneNumber};EMAIL:${contactData.email};;';
    case 'sms':
      final SMSData smsData = qrCodeData as SMSData;
      return 'SMSTO:${smsData.phoneNumber}';
    case 'email':
      final EmailData emailData = qrCodeData as EmailData;
      return 'mailto:${emailData.email}?subject=${emailData.subject}&body=${emailData.content}';
    case 'website':
      final WebsiteData websiteData = qrCodeData as WebsiteData;
      return websiteData.url;
    case 'mobileNumber':
      final MobileNumberData mobileNumberData = qrCodeData as MobileNumberData;
      return 'tel:${mobileNumberData.number}';
    case 'myContactCard':
      final MyContactCardData myContactCardData =
          qrCodeData as MyContactCardData;
      return 'MECARD:N:${myContactCardData.name};TEL:${myContactCardData.phoneNumber};EMAIL:${myContactCardData.email};ADR:${myContactCardData.address};BD:${myContactCardData.birthDate};ORG:${myContactCardData.organization};;';
    default:
      throw Exception('Unsupported QR code type: ${qrCodeData.type}');
  }
}
