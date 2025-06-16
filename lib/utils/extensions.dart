import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ScreenSizeExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}

extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => Theme.of(this).colorScheme;
}
