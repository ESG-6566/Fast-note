import 'package:flutter/material.dart';
import 'package:flutter_application_test2/UserData.dart';

class MyTheme {
  static Color light = Color(0xFFFBFBFF);
  static Color backgroundHigher = Color(0xFFEEEEEE);
  static Color highDark = Color(0xFF0B4F6C);
  static Color colorA = Color(0xFF20BF55);
  static Color colorB = Color(0xFF01BAEF);
  static Color text = Color(0xFF000000);
  static Color lowtText = Color(0xFF787878);
  static Color background = Color(0xFFFBFBFF);
  static Color noColor = Colors.transparent;
  static Color highlight = Color(0xFFffbf69);
  static Color buttonText = Color.fromARGB(255, 255, 255, 255);

  static void Switch(MyThemeMode themeMode) {
    switch (themeMode) {
      case MyThemeMode.dark:
        light = Color(0xFFB9D6F2);
        backgroundHigher = Color(0xFF00253D);
        highDark = Color(0xFF001829);
        colorA = Color(0xFF00253D);
        colorB = Color(0xFF00497A);
        text = Color.fromARGB(255, 220, 220, 220);
        lowtText = Color.fromARGB(255, 130, 130, 130);
        background = Color(0xFF000C14);
        highlight = Color(0xFF0096c7);
        buttonText = Color.fromARGB(255, 220, 220, 220);

        UserData.currentTheme = MyThemeMode.dark;
        UserData.saveData();
        break;
      case MyThemeMode.defaultMode:
        light = Color(0xFFFBFBFF);
        backgroundHigher = Color(0xFFEEEEEE);
        highDark = Color(0xFF0B4F6C);
        colorA = Color(0xFF20BF55);
        colorB = Color(0xFF01BAEF);
        text = Color(0xFF000000);
        lowtText = Color(0xFF787878);
        background = Color(0xFFFBFBFF);
        UserData.currentTheme = MyThemeMode.defaultMode;
        highlight = Color(0xFFffbf69);
        buttonText = Color.fromARGB(255, 255, 255, 255);

        UserData.currentTheme = MyThemeMode.defaultMode;
        UserData.saveData();
        break;
      case MyThemeMode.light:
        // TODO: Handle this case.
        break;
    }
  }
}

enum MyThemeMode { dark, light, defaultMode }
