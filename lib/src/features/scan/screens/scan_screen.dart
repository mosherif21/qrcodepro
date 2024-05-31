import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcodepro/src/constants/colors.dart';
import 'package:qrcodepro/src/features/scan/controllers/scan_screen_controller.dart';
import 'package:qrcodepro/src/general/general_functions.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanScreenController = Get.put(ScanScreenController());
    final screenHeight = getScreenHeight(context);
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Obx(
                        () => scanScreenController.resultCode.value.isNotEmpty
                            ? Text(
                                'Barcode Type: ${describeEnum(scanScreenController.resultFormat)}   Data: ${scanScreenController.resultCode}',
                                style: const TextStyle(color: Colors.blue),
                              )
                            : const Text(
                                'Scan a code',
                                style: TextStyle(color: Colors.blue),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                await scanScreenController.qrController
                                    ?.toggleFlash();
                              },
                              child: Text('Flash'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                await scanScreenController.qrController
                                    ?.flipCamera();
                              },
                              child: Text('Camera facing'),
                            ),
                          )
                        ],
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
