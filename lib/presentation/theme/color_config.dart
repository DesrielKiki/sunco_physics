import 'package:flutter/material.dart';

class ColorConfig {
  static const Color primaryColor = softCyan;
  static const Color onPrimaryColor = Colors.white;
  static const Color black = Color(0xff080808);
  static const Color softCyan = Color(0xff60EFFF);
  static const Color darkBlue = Color(0xff0061FF);
  static const LinearGradient gradientBrand = LinearGradient(colors: [
    darkBlue,
    softCyan,
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
