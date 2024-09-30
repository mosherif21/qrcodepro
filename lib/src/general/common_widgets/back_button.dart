// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcodepro/src/constants/colors.dart';

class RegularBackButton extends StatelessWidget {
  const RegularBackButton({Key? key, required this.padding}) : super(key: key);
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: IconButton(
        splashRadius: 22,
        icon: const Center(
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: kDarkBlueColor,
            size: 28,
          ),
        ),
        onPressed: () => Get.back(),
      ),
    );
  }
}

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({
    Key? key,
    required this.padding,
    required this.onPress,
  }) : super(key: key);
  final double padding;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Material(
        elevation: 5,
        shape: const CircleBorder(),
        color: Colors.white,
        child: InkWell(
          customBorder: const CircleBorder(),
          splashFactory: InkSparkle.splashFactory,
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_back_ios_sharp,
              size: 28,
            ),
          ),
          onTap: () => onPress(),
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton(
      {Key? key, required this.onPressed, required this.padding})
      : super(key: key);
  final Function onPressed;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        children: [
          IconButton(
            splashRadius: 22,
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              size: 28,
            ),
            onPressed: () => onPressed(),
          ),
        ],
      ),
    );
  }
}
