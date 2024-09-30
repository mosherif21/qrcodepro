import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:qrcodepro/src/constants/enums.dart';
import 'package:qrcodepro/src/features/database/hive_functions.dart';
import 'package:qrcodepro/src/features/scan/components/scanned_qrcode_details.dart';
import 'package:qrcodepro/src/general/app_init.dart';
import 'package:qrcodepro/src/general/general_functions.dart';

class ScanScreenController extends GetxController {
  static ScanScreenController get instance => Get.find();

  final qrControllerCreated = false.obs;
  final flashOn = false.obs;
  final frontCamera = false.obs;
  late BarcodeFormat resultFormat;
  late final QRViewController? cameraQrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void onQRViewCreated(QRViewController controller) {
    if (!qrControllerCreated.value) {
      cameraQrController = controller;
      qrControllerCreated.value = true;
      controller.scannedDataStream.listen((scanData) {
        if (scanData.code != null) {
          final resultValue = scanData.code!.trim();
          final resultQrcodeData = generateQRCodeData(qrCodeText: resultValue);
          Get.to(
              () => QrcodeDetails(
                    qrCodeData: resultQrcodeData,
                  ),
              transition: getPageTransition());
        }
      });
    }
  }

  void onFlashTogglePress() async {
    await cameraQrController!.toggleFlash();
    flashOn.value = !flashOn.value;
  }

  void onFlipCameraPress() async {
    await cameraQrController!.flipCamera();
    frontCamera.value = !frontCamera.value;
  }

  void onOpenGalleryPress() async {
    showLoadingScreen();
    try {
      final picker = ImagePicker();
      final addedImage = await picker.pickImage(source: ImageSource.gallery);
      if (addedImage != null) {
        final result = await QrCodeToolsPlugin.decodeFrom(addedImage.path);
        if (result != null) {
          hideLoadingScreen();
          final resultValue = result.trim();
          final resultQrcodeData = generateQRCodeData(qrCodeText: resultValue);

          Get.to(
              () => QrcodeDetails(
                    qrCodeData: resultQrcodeData,
                  ),
              transition: getPageTransition());
        } else {
          hideLoadingScreen();
          showSnackBar(
              text: 'qrcodeNotFound'.tr, snackBarType: SnackBarType.error);
        }
      } else {
        hideLoadingScreen();
        showSnackBar(
            text: 'noImageChosen'.tr, snackBarType: SnackBarType.error);
      }
    } catch (exception) {
      hideLoadingScreen();
      AppInit.logger.e(exception.toString());
      showSnackBar(text: 'errorOccurred'.tr, snackBarType: SnackBarType.error);
    }
  }
}
  //  final imagePath = await storeQrCodeImage(resultQrImage);
  // // Save a QR code
  //         await saveQRCodeData(
  //           GenericQRCodeData(value: resultValue, imagePath: imagePath),
  //           QrCodeDataStoreType.scanned,
  //         );
  
  //  final imagePath =
  //             await storeQrCodeImage(Uint8List.fromList(resultQrBytes!));

  //         // Save a QR code
  //         await saveQRCodeData(
  //           GenericQRCodeData(value: resultValue, imagePath: imagePath),
  //           QrCodeDataStoreType.scanned,
  //         );
  //         // Retrieve all saved QR codes
  //         final qrCodes = await getQRCodeData(QrCodeDataStoreType.scanned);

  //         for (final qrCode in qrCodes) {
  //           if (qrCode is GenericQRCodeData) {
  //             showSnackBar(
  //               text: 'Value: ${qrCode.value} image path: ${qrCode.imagePath}',
  //               snackBarType: SnackBarType.success,
  //             );
  //           }
  //         }