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
          onPressed: isEnabled ? onTap : null,
          color: isFilled ? context.theme.primaryColor : null,
          textColor: isFilled ? Colors.white : context.theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: isFilled
                ? BorderSide.none
                : BorderSide(color: context.theme.primaryColor, width: 2.0),
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
