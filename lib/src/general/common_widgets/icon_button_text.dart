import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class IconButtonText extends StatelessWidget {
  const IconButtonText(
      {super.key,
      required this.onPress,
      required this.iconColor,
      required this.textColor,
      required this.icon,
      required this.buttonText});
  final Function onPress;
  final Color iconColor;
  final Color textColor;
  final IconData icon;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          splashColor: Colors.black54,
          hoverColor: Colors.grey.shade50,
          splashFactory: InkSparkle.splashFactory,
          onTap: () => onPress(),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor),
                AutoSizeText(
                  buttonText,
                  maxLines: 1,
                  style:
                      TextStyle(color: textColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
