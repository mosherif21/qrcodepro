import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcodepro/src/features/database/hive_models.dart';
import 'package:qrcodepro/src/general/common_widgets/back_button.dart';

class QrcodeDetails extends StatelessWidget {
  final QRCodeData qrCodeData;
  const QrcodeDetails({
    super.key,
    required this.qrCodeData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const RegularBackButton(padding: 0),
        title: AutoSizeText(
          'qrcodeDetails'.tr,
          maxLines: 1,
        ),
        titleTextStyle: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(qrCodeData.type),
          // SizedBox(
          //   height: 200,
          //   child: SfBarcodeGenerator(
          //     value: qrCodeData,
          //     symbology: QRCode(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
