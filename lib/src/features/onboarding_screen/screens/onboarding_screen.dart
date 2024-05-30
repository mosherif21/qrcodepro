import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:qrcodepro/src/general/general_functions.dart';

import '../../../constants/assets_strings.dart';
import '../../../constants/colors.dart';
import '../../../general/common_widgets/language_select.dart';
import '../../../general/common_widgets/regular_bottom_sheet.dart';
import '../components/onboarding_functions.dart';
import '../components/onboarding_page_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = getScreenHeight(context);
    return OnBoardingSlider(
      finishButtonText: 'continueApp'.tr,
      onFinish: () {
        RegularBottomSheet.showRegularBottomSheet(
          LanguageSelect(
            onEnglishLanguagePress: () {
              setOnBoardingLocaleLanguage(
                'en',
              );
            },
            onArabicLanguagePress: () {
              setOnBoardingLocaleLanguage(
                'ar',
              );
            },
          ),
        );
      },
      finishButtonStyle: const FinishButtonStyle(
          backgroundColor: kDarkBlueColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)))),
      trailing: Text(
        'privacyPolicy'.tr,
        style: const TextStyle(
          fontSize: 16,
          color: kDarkBlueColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {},
      skipTextButton: AutoSizeText(
        'Skip'.tr,
        style: const TextStyle(
          fontSize: 16,
          color: kDarkBlueColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      controllerColor: kDarkBlueColor,
      totalPage: 4,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      centerBackground: true,
      background: [
        Image.asset(
          kOnBoardingScanImage,
          height: screenHeight * 0.45,
        ),
        Image.asset(
          kOnBoardingCreateImage,
          height: screenHeight * 0.55,
        ),
        Image.asset(
          kOnBoardingShareImage,
          height: screenHeight * 0.55,
        ),
        Image.asset(
          kLogoLightImage,
          height: screenHeight * 0.55,
        ),
      ],
      speed: 1.8,
      pageBodies: [
        for (int i = 1; i < 5; i++)
          OnboardingPageWidget(
            onBoardingTitle: 'onBoardingTitle$i'.tr,
            onBoardingDescription: 'onBoardingDescription$i'.tr,
          ),
      ],
    );
  }
}
