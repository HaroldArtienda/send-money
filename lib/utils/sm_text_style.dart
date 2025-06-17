import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:send_money/utils/extensions.dart';

class SMTextStyle {
  static loginTitle(BuildContext ctx) => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: ctx.theme.primaryColor,
      );

  static moneyTitle(BuildContext ctx) => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: ctx.theme.primaryColor,
      );

  static balanceTitle() => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.blueGrey,
      );
}
