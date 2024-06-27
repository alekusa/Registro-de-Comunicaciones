import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextStyle get tituloStyle {
  return TextStyle(
      fontFamily: 'Lato',
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.white : Colors.grey);
}

TextStyle get subTituloStyle {
  return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]);
}
