import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:qrcodepro/src/general/app_init.dart';
import 'package:qrcodepro/src/general/theme.dart';

import 'localization/language/localization_strings.dart';

void main() async {
  await AppInit.initialize().whenComplete(() => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: NonScrollPhysics(),
          child: child!,
        );
      },
      translations: Languages(),
      locale: AppInit.setLocale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: AppInit.getInitialPage(),
    );
  }
}

class NonScrollPhysics extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
