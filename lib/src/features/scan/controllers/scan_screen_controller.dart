import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreenController extends GetxController {
  static ScanScreenController get instance => Get.find();
  final resultCode = ''.obs;
  final qrControllerCreated = false.obs;
  late BarcodeFormat resultFormat;
  late final QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void onQRViewCreated(QRViewController controller) {
    if (!qrControllerCreated.value) {
      qrController = controller;
      qrControllerCreated.value = true;
      controller.scannedDataStream.listen((scanData) {
        if (scanData.code != null) {
          resultFormat = scanData.format;
          resultCode.value = scanData.code!;
        }
      });
    }
  }
}
