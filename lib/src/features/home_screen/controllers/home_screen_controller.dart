import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();

  final navBarIndex = 0.obs;

  navigationBarOnTap(int navIndex) => navBarIndex.value = navIndex;
}
