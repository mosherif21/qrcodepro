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
