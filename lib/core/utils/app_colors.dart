import 'package:flutter/material.dart';

class AppColors {
  static Color logoColor = Color(colorFroHex('6A704C'));
  static Color logoBackgroundColor = Color(colorFroHex('EDE1D1'));
  static Color appBarColor = Color(colorFroHex('EEEDEB'));
  static Color primaryColor = Color(colorFroHex('2F3645'));
  static Color secondColor = Color(colorFroHex('5F5FA7'));
  static Color scaffoldColor = Color(colorFroHex('E6B9A6'));
  static Color thirdColor = Color(colorFroHex('939185'));
  static Color backgroundItemsColor = Color(colorFroHex('f3f3f3'));
  static Color newLogoBackgroundColors = Color(colorFroHex('FFF2EA'));
}

int colorFroHex(String colorHex) {
  return int.parse('0xff$colorHex');
}
