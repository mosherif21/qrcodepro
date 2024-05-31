import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcodepro/src/constants/colors.dart';
import 'package:qrcodepro/src/features/scan/controllers/scan_screen_controller.dart';

import '../controllers/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenController = Get.put(HomeScreenController());
    return Scaffold(
      body: PageView(
        controller: homeScreenController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(homeScreenController.bottomBarPages.length,
            (index) => homeScreenController.bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (homeScreenController.bottomBarPages.length <=
              homeScreenController.maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController:
                  homeScreenController.navigationController,
              color: Colors.white,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: true,
              durationInMilliSeconds: 300,
              itemLabelStyle: const TextStyle(fontSize: 10),
              elevation: 1,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.grey,
                  ),
                  activeItem: const Icon(
                    Icons.qr_code_scanner,
                    color: kDarkBlueColor,
                  ),
                  itemLabel: 'scan'.tr,
                ),
                BottomBarItem(
                  inActiveItem: const Icon(
                    Icons.history,
                    color: Colors.grey,
                  ),
                  activeItem: const Icon(
                    Icons.history,
                    color: kDarkBlueColor,
                  ),
                  itemLabel: 'history'.tr,
                ),
                BottomBarItem(
                  inActiveItem: const Icon(
                    Icons.add_box_outlined,
                    color: Colors.grey,
                  ),
                  activeItem: const Icon(
                    Icons.add_box_outlined,
                    color: kDarkBlueColor,
                  ),
                  itemLabel: 'create'.tr,
                ),
                BottomBarItem(
                  inActiveItem: const Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  activeItem: const Icon(
                    Icons.settings,
                    color: kDarkBlueColor,
                  ),
                  itemLabel: 'settings'.tr,
                ),
              ],
              onTap: (index) {
                homeScreenController.pageController.jumpToPage(index);
                if (index != 0 && Get.isRegistered<ScanScreenController>()) {
                  Get.delete<ScanScreenController>();
                }
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}
