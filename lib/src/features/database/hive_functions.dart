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
  Hive.registerAdapter(NumberDataAdapter());
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
  if (qrCodeText.isEmpty) {
    return GenericQRCodeData(value: qrCodeText); // Handle empty QR code text
  }

  // Extract the prefix before the colon, for case-insensitive comparison
  final prefix =
      qrCodeText.contains(':') ? qrCodeText.split(':').first.toUpperCase() : '';

  switch (prefix) {
    case 'WIFI':
      // Parse Wifi data
      final parts = qrCodeText.split(';');
      if (parts.length < 4) {
        return GenericQRCodeData(value: qrCodeText); // Handle missing parts
      }

      final ssidPart =
          parts.firstWhere((part) => part.startsWith('S:'), orElse: () => '');
      final ssid = ssidPart.isNotEmpty ? ssidPart.split(':')[1] : '';

      final passwordPart =
          parts.firstWhere((part) => part.startsWith('P:'), orElse: () => '');
      final password =
          passwordPart.isNotEmpty ? passwordPart.split(':')[1] : '';

      final securityTypePart =
          parts.firstWhere((part) => part.startsWith('T:'), orElse: () => '');
      final securityTypeString =
          securityTypePart.isNotEmpty ? securityTypePart.split(':')[1] : '';

      WifiSecurityType securityType;
      try {
        securityType = WifiSecurityType.values.byName(securityTypeString);
      } catch (e) {
        securityType = WifiSecurityType.none; // Default fallback
      }

      final hiddenPart = parts.firstWhere((part) => part.startsWith('H:'),
          orElse: () => 'H:false');
      final isHidden = hiddenPart.split(':')[1] == 'true';

      return WifiData(
          ssid: ssid,
          password: password,
          securityType: securityType,
          isHidden: isHidden);

    case 'MECARD':
      // Parse Contact or MyContactCard data
      final List<String> fields = qrCodeText.split(';');

      final nameField = fields.firstWhere((field) => field.startsWith('N:'),
          orElse: () => '');
      final name = nameField.length > 2 ? nameField.substring(2) : '';

      final phoneNumberField = fields
          .firstWhere((field) => field.startsWith('TEL:'), orElse: () => '');
      final phoneNumber =
          phoneNumberField.length > 4 ? phoneNumberField.substring(4) : '';

      final emailField = fields
          .firstWhere((field) => field.startsWith('EMAIL:'), orElse: () => '');
      final email = emailField.length > 6 ? emailField.substring(6) : '';

      final addressField = fields
          .firstWhere((field) => field.startsWith('ADR:'), orElse: () => '');
      final address = addressField.length > 4 ? addressField.substring(4) : '';

      final birthDateField = fields
          .firstWhere((field) => field.startsWith('BD:'), orElse: () => '');
      final birthDate =
          birthDateField.length > 3 ? birthDateField.substring(3) : '';

      final organizationField = fields
          .firstWhere((field) => field.startsWith('ORG:'), orElse: () => '');
      final organization =
          organizationField.length > 4 ? organizationField.substring(4) : '';

      if (address.isNotEmpty ||
          birthDate.isNotEmpty ||
          organization.isNotEmpty) {
        return MyContactCardData(
          name: name,
          phoneNumber: phoneNumber,
          email: email,
          address: address,
          birthDate: birthDate,
          organization: organization,
        );
      } else {
        return ContactData(name: name, phoneNumber: phoneNumber, email: email);
      }

    case 'SMSTO':
      // Parse SMS data
      final phoneNumber = qrCodeText.length > 6 ? qrCodeText.substring(6) : '';
      return SMSData(phoneNumber: phoneNumber, msgBody: '');

    case 'MAILTO':
      // Parse Email data
      final email = qrCodeText.length > 7 ? qrCodeText.substring(7) : '';
      return EmailData(email: email, subject: '', content: '');

    case 'HTTP':
    case 'HTTPS':
      // Parse Website data
      return WebsiteData(url: qrCodeText);

    case 'TEL':
      // Parse Mobile number data
      final number = qrCodeText.length > 4 ? qrCodeText.substring(4) : '';
      return NumberData(number: number);

    default:
      // Generic data type (no specific format detected)
      return GenericQRCodeData(value: qrCodeText);
  }
}

String generateQRCodeText({required QRCodeData qrCodeData}) {
  switch (qrCodeData.type) {
    case 'wifi':
      final WifiData wifiData = qrCodeData as WifiData;
      return 'WIFI:T:WPA;S:${wifiData.ssid};P:${wifiData.password};H:${wifiData.isHidden};';

    case 'contact':
      final ContactData contactData = qrCodeData as ContactData;
      return 'MECARD:N:${contactData.name};TEL:${contactData.phoneNumber};EMAIL:${contactData.email};;';

    case 'sms':
      final SMSData smsData = qrCodeData as SMSData;
      return 'SMSTO:${smsData.phoneNumber}';

    case 'email':
      final EmailData emailData = qrCodeData as EmailData;
      return 'mailto:${emailData.email}?subject=${Uri.encodeComponent(emailData.subject)}&body=${Uri.encodeComponent(emailData.content)}';

    case 'website':
      final WebsiteData websiteData = qrCodeData as WebsiteData;
      return websiteData.url;

    case 'mobileNumber':
      final NumberData numberData = qrCodeData as NumberData;
      return 'tel:${numberData.number}';

    case 'myContactCard':
      final MyContactCardData myContactCardData =
          qrCodeData as MyContactCardData;
      return 'MECARD:N:${myContactCardData.name};'
          '${myContactCardData.phoneNumber.isNotEmpty ? "TEL:${myContactCardData.phoneNumber};" : ""}'
          '${myContactCardData.email.isNotEmpty ? "EMAIL:${myContactCardData.email};" : ""}'
          '${myContactCardData.address.isNotEmpty ? "ADR:${myContactCardData.address};" : ""}'
          '${myContactCardData.birthDate.isNotEmpty ? "BD:${myContactCardData.birthDate};" : ""}'
          '${myContactCardData.organization.isNotEmpty ? "ORG:${myContactCardData.organization};" : ""};;';

    default:
      throw Exception('Unsupported QR code type: ${qrCodeData.type}');
  }
}
