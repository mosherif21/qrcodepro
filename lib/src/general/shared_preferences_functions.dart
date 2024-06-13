import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../localization/language/language_functions.dart';
import '../features/home_screen/screens/home_screen.dart';
import 'app_init.dart';
import 'general_functions.dart';

late SharedPreferences _prefs;
Future<void> setShowOnBoarding() async {
  _prefs = await SharedPreferences.getInstance();
  await _prefs.setString("onboarding", "true");
}

Future<bool> getShowOnBoarding() async {
  _prefs = await SharedPreferences.getInstance();
  if (_prefs.getString("onboarding") == "true") {
    return false;
  } else {
    return true;
  }
}

Future<void> setOnBoardingLocaleLanguage(String languageCode) async {
  showLoadingScreen();
  await setOnBoardingLocale(languageCode).whenComplete(() {
    AppInit.showOnBoard = false;
    Get.offAll(() => const HomeScreen());
  });
}
