import 'package:flutter/material.dart';

class Custom {
  static TextStyle textStyle(
    Color color, {
    String fontFamily = 'FarKoodak',
    double fontSize = 18.0,
  }) {
    return TextStyle(fontFamily: fontFamily, fontSize: fontSize, color: color);
  }
}
