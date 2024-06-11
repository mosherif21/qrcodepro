import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class IconButtonText extends StatelessWidget {
  const IconButtonText({
    super.key,
    required this.onPress,
    required this.iconColor,
    required this.textColor,
    required this.icon,
    required this.buttonText,
    required this.isEnabled,
  });
  final Function onPress;
  final bool isEnabled;
  final Color iconColor;
  final Color textColor;
  final IconData icon;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Opacity(
        opacity: isEnabled ? 1 : 0.5,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            splashColor: isEnabled ? Colors.grey.shade500 : Colors.transparent,
            splashFactory: InkSparkle.splashFactory,
            onTap: isEnabled ? () => onPress() : null,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: isEnabled ? iconColor : Colors.grey),
                  AutoSizeText(
                    buttonText,
                    maxLines: 1,
                    style: TextStyle(
                        color: isEnabled ? textColor : Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
