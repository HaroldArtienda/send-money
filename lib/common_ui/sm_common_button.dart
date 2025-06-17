import 'package:flutter/material.dart';
import 'package:send_money/utils/extensions.dart';

class SMCommonButton extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final bool isFilled;
  final bool isEnabled;
  final VoidCallback? onTap;

  const SMCommonButton({
    super.key,
    required this.height,
    required this.width,
    this.title = "",
    this.isFilled = false,
    this.isEnabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: null,
        borderRadius: BorderRadius.circular(16.0),
        child: MaterialButton(
          onPressed: isEnabled ? onTap : () {},
          color: isEnabled
              ? (isFilled ? context.theme.primaryColor : null)
              : (isFilled ? Colors.grey.shade600 : null),
          textColor: isEnabled
              ? (isFilled ? Colors.white : context.theme.primaryColor)
              : (isFilled ? Colors.white : Colors.grey.shade600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: isFilled
                ? BorderSide.none
                : BorderSide(
                    color: isEnabled
                        ? context.theme.primaryColor
                        : Colors.grey.shade600,
                    width: 2.0,
                  ),
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
