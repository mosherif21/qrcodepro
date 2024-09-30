import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcodepro/src/constants/colors.dart';

class QrCodeDetailsController extends GetxController {
  static QrCodeDetailsController get instance => Get.find();
  Widget titleWidget({required String title, required IconData icon}) {
    return Center(
      child: Row(children: [
        const SizedBox(width: 40),
        Icon(icon, color: kDarkBlueColor, size: 35),
        const SizedBox(width: 10),
        AutoSizeText(
          title,
          maxLines: 1,
        ),
      ]),
    );
  }

  Widget getScreenTitle(String qrCodeType) {
    switch (qrCodeType) {
      case 'wifi':
        return titleWidget(title: 'wifi'.tr, icon: Icons.wifi);
      case 'contact':
        return titleWidget(title: 'contact'.tr, icon: Icons.contact_phone);
      case 'sms':
        return titleWidget(title: 'sms'.tr, icon: Icons.sms);
      case 'email':
        return titleWidget(title: 'email'.tr, icon: Icons.email);
      case 'myContactCard':
        return titleWidget(title: 'myContactCard'.tr, icon: Icons.contact_page);
      case 'website':
        return titleWidget(title: 'website'.tr, icon: Icons.link_rounded);
      case 'number':
        return titleWidget(title: 'number'.tr, icon: Icons.call);
      default:
        return titleWidget(title: 'qrcode'.tr, icon: Icons.qr_code);
    }
  }
}
