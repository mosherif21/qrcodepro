import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcodepro/src/general/general_functions.dart';

import '../../scan/screens/scan_screen.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();
  @override
  void onReady() async {
    await handleCameraPermission();
    // await handleStoragePermission();
    super.onReady();
  }
  // final navBarIndex = 0.obs;
  // navigationBarOnTap(int navIndex) => navBarIndex.value = navIndex;

  /// Controller to handle PageView and also handles initial page
  final pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final navigationController = NotchBottomBarController(index: 0);

  final maxCount = 5;

  /// widget list
  final List<Widget> bottomBarPages = [
    const ScanScreen(),
    const Page2(),
    const Page3(),
    const Page4(),
  ];
}

/// add controller to check weather index through change or not. in page 1
class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green, child: const Center(child: Text('Page 2')));
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red, child: const Center(child: Text('Page 3')));
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue, child: const Center(child: Text('Page 4')));
  }
}
