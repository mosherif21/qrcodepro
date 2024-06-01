import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcodepro/src/constants/colors.dart';
import 'package:qrcodepro/src/features/scan/controllers/scan_screen_controller.dart';
import 'package:qrcodepro/src/general/common_widgets/icon_button_text.dart';
import 'package:qrcodepro/src/general/general_functions.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanScreenController = Get.put(ScanScreenController());
    final screenHeight = getScreenHeight(context);
    final screenWidth = getScreenWidth(context);
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: scanScreenController.qrKey,
            onQRViewCreated: scanScreenController.onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: kDarkBlueColor,
              borderRadius: 10,
              borderLength: 20,
              borderWidth: 10,
              cutOutSize: screenHeight * 0.3,
            ),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
          Obx(
            () => scanScreenController.qrControllerCreated.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.7),
                      Center(
                        child: Container(
                          width: screenWidth * 0.6,
                          decoration: const BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.all(Radius.circular(28)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButtonText(
                                onPress:
                                    scanScreenController.onOpenGalleryPress,
                                iconColor: kDarkBlueColor,
                                textColor: kDarkBlueColor,
                                icon: Icons.image,
                                buttonText: 'gallery'.tr,
                              ),
                              Obx(
                                () => IconButtonText(
                                  onPress: scanScreenController
                                          .togglingFlash.value
                                      ? () {}
                                      : scanScreenController.onFlashTogglePress,
                                  iconColor: scanScreenController.flashOn.value
                                      ? kDarkBlueColor
                                      : Colors.grey,
                                  textColor: kDarkBlueColor,
                                  icon: Icons.flash_on,
                                  buttonText: 'flash'.tr,
                                ),
                              ),
                              Obx(
                                () => IconButtonText(
                                  onPress: scanScreenController
                                          .flippingCamera.value
                                      ? () {}
                                      : scanScreenController.onFlipCameraPress,
                                  iconColor: kDarkBlueColor,
                                  textColor: kDarkBlueColor,
                                  icon: Icons.camera_front_outlined,
                                  buttonText: 'flip'.tr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  void _onPermissionSet(
      BuildContext context, QRViewController ctrl, bool granted) {
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
