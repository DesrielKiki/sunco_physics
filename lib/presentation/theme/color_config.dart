import 'package:flutter/material.dart';

class ColorConfig {
  static const Color primaryColor = darkBlue;
  static const Color onPrimaryColor = solidWhite;
  static const Color solidWhite = Color(0xffF6F6F6);
  static const Color black = Color(0xff080808);
  static const Color softCyan = Color(0xff60EFFF);
  static const Color darkBlue = Color(0xff0061FF);
  static const Color grey = Color(0xffD9D9D9);
  static const Color darkGrey = Color(0xff7D7B80);
  static const Color redWarning = Color(0xffFF0000);
  static const Color green = Color(0xFF0FD318);
  static const LinearGradient gradientBrand = LinearGradient(colors: [
    darkBlue,
    softCyan,
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static const LinearGradient gradientBrandReverse = LinearGradient(colors: [
    softCyan,
    darkBlue,
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
