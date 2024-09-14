import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_sdk/flutter_barcode_sdk.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcodepro/src/constants/enums.dart';
import 'package:qrcodepro/src/features/database/hive_functions.dart';
import 'package:qrcodepro/src/features/database/hive_models.dart';
import 'package:qrcodepro/src/general/app_init.dart';
import 'package:qrcodepro/src/general/general_functions.dart';
import '../../../constants/no_localization_strings.dart';

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
          showSnackBar(
              text: resultCode.value, snackBarType: SnackBarType.success);
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
    try {
      final picker = ImagePicker();
      final addedImage = await picker.pickImage(source: ImageSource.gallery);
      if (addedImage != null) {
        if (!barcodeReaderInitialized) {
          _barcodeReader = FlutterBarcodeSdk();
          await _barcodeReader.setLicense(kBarcodeScanLicense);
          await _barcodeReader.init();
          barcodeReaderInitialized = true;
        }
        final results = await _barcodeReader.decodeFile(addedImage.path);
        hideLoadingScreen();
        if (results.isNotEmpty) {
          // showSnackBar(
          //     text:
          //         'Format: ${results.first.format} Code: ${results.first.text}',
          //     snackBarType: SnackBarType.success);

          final ssid = results.first.text;

          // Save a QR code
          await saveQRCodeData(WifiData(
            ssid: ssid,
            password: 'myPassword',
            securityType: WifiSecurityType.wpa2,
          ));

          // Retrieve all saved QR codes
          final qrCodes = await getQRCodeData();
          for (final qrCode in qrCodes) {
            if (qrCode is WifiData) {
              showSnackBar(
                  text: qrCode.ssid, snackBarType: SnackBarType.success);
            }
          }
        } else {
          showSnackBar(
              text: 'qrcodeNotFound'.tr, snackBarType: SnackBarType.error);
        }
      } else {
        hideLoadingScreen();
        showSnackBar(
            text: 'An error occurred, Please try again',
            snackBarType: SnackBarType.error);
      }
    } catch (exception) {
      AppInit.logger.e(exception.toString());
      showSnackBar(text: 'errorOccurred'.tr, snackBarType: SnackBarType.error);
    }
  }
}
