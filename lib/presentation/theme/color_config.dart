import 'package:flutter/material.dart';

class ColorConfig {
  static const Color primaryColor = darkBlue;
  static const Color onPrimaryColor = solidWhite;
  static const Color solidWhite = Color(0xffF6F6F6);
  static const Color black = Color(0xff080808);
  static const Color softCyan = Color(0xff60EFFF);
  static const Color darkBlue = Color(0xff0061FF);
  static const LinearGradient gradientBrand = LinearGradient(colors: [
    darkBlue,
    softCyan,
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
