import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcodepro/src/constants/colors.dart';

import '../controllers/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenController = Get.put(HomeScreenController());
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => homeScreenController.navBarIndex.value == 0
                ? const Scaffold(backgroundColor: Colors.white60)
                : homeScreenController.navBarIndex.value == 1
                    ? const Scaffold(backgroundColor: Colors.blue)
                    : homeScreenController.navBarIndex.value == 2
                        ? const Scaffold(backgroundColor: Colors.purple)
                        : const Scaffold(backgroundColor: Colors.grey),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(
                () => CustomNavigationBar(
                  iconSize: 30.0,
                  selectedColor: kDarkBlueColor,
                  strokeColor: kDarkBlueShadeColor,
                  unSelectedColor: Colors.grey[600],
                  backgroundColor: Colors.white,
                  elevation: 5,
                  borderRadius: const Radius.circular(20.0),
                  items: [
                    CustomNavigationBarItem(
                      icon: const Icon(Icons.qr_code_scanner),
                      title: AutoSizeText(
                        'Scan',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: homeScreenController.navBarIndex.value == 0
                              ? kDarkBlueColor
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                    CustomNavigationBarItem(
                      icon: const Icon(Icons.history_outlined),
                      title: AutoSizeText(
                        'History',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: homeScreenController.navBarIndex.value == 1
                              ? kDarkBlueColor
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                    CustomNavigationBarItem(
                      icon: const Icon(Icons.add_box_outlined),
                      title: AutoSizeText(
                        'Create',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: homeScreenController.navBarIndex.value == 2
                              ? kDarkBlueColor
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                    CustomNavigationBarItem(
                      icon: const Icon(Icons.settings),
                      title: AutoSizeText(
                        'Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: homeScreenController.navBarIndex.value == 3
                              ? kDarkBlueColor
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                  currentIndex: homeScreenController.navBarIndex.value,
                  onTap: homeScreenController.navigationBarOnTap,
                  isFloating: true,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
