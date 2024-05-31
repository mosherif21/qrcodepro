import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreenController extends GetxController {
  static ScanScreenController get instance => Get.find();
  final resultCode = ''.obs;
  final qrControllerCreated = false.obs;
  final flashOn = false.obs;
  final togglingFlash = false.obs;
  final flippingCamera = false.obs;
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

  void onFlashTogglePress() async {
    togglingFlash.value = true;
    await qrController!.toggleFlash();
    togglingFlash.value = false;
    flashOn.value = !flashOn.value;
  }

  void onFlipCameraPress() async {
    flippingCamera.value = true;
    await qrController!.flipCamera();
    flippingCamera.value = false;
  }

  void onOpenGalleryPress() async {
    // await qrController!.flipCamera();
  }
}
