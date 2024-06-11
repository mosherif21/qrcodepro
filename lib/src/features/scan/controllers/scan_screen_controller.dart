import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_sdk/flutter_barcode_sdk.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcodepro/src/constants/enums.dart';
import 'package:qrcodepro/src/general/general_functions.dart';

//'Barcode Type: ${describeEnum(scanScreenController.resultFormat)}   Data: ${scanScreenController.resultCode}',

class ScanScreenController extends GetxController {
  static ScanScreenController get instance => Get.find();
  final resultCode = ''.obs;
  final qrControllerCreated = false.obs;
  final flashOn = false.obs;
  final frontCamera = false.obs;
  late BarcodeFormat resultFormat;
  late final QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool barcodeReaderInitialized = false;
  late final FlutterBarcodeSdk _barcodeReader;

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
    await qrController!.toggleFlash();
    flashOn.value = !flashOn.value;
  }

  void onFlipCameraPress() async {
    await qrController!.flipCamera();
    frontCamera.value = !frontCamera.value;
  }

  void onOpenGalleryPress() async {
    showLoadingScreen();
    final picker = ImagePicker();
    final addedImage = await picker.pickImage(source: ImageSource.gallery);
    if (addedImage != null) {
      if (!barcodeReaderInitialized) {
        _barcodeReader = FlutterBarcodeSdk();
        await _barcodeReader.setLicense(
            'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
        await _barcodeReader.init();
        barcodeReaderInitialized = true;
      }
      final results = await _barcodeReader.decodeFile(addedImage.path);
      hideLoadingScreen();
      showSnackBar(
          text: 'Format: ${results.first.format} Code: ${results.first.text}',
          snackBarType: SnackBarType.error);
    } else {
      hideLoadingScreen();
      showSnackBar(
          text: 'An error occurred, Please try again',
          snackBarType: SnackBarType.error);
    }
  }
}
