import 'package:flutter_application_test2/MyTheme.dart';

class MyCalculate {
  /// Calculate date without time
  static DateTime currentDate() {
    DateTime now = DateTime.now();
    DateTime current = DateTime(now.year, now.month, now.day);
    return current;
  }

  /// Calculate days between two date
  static int daysBetween(DateTime date1, DateTime date2) {
    Duration difference = date2.difference(date1);
    int daysDifference = difference.inDays;
    return daysDifference;
  }

  static bool isArabic(String text) {
    // Arabic characters Unicode range: U+0600 to U+06FF
    // Source: https://en.wikipedia.org/wiki/Arabic_script_in_Unicode
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  static bool isEnglish(String text) {
    // English characters Unicode range: U+0041 to U+007A
    // Source: https://en.wikipedia.org/wiki/List_of_Unicode_characters
    final englishRegex = RegExp(r'[\u0041-\u007A]');
    return englishRegex.hasMatch(text);
  }

  static MyThemeMode stringToThemeMode(String string) {
    // Extract the enum name and value from the string
    List<String> parts = string.split('.');
    String enumName = parts[0];
    String enumValue = parts[1];

    // Get the enum value using reflection
    MyThemeMode myEnumValue = MyThemeMode.values
        .firstWhere((e) => e.toString() == '$enumName.$enumValue');

    return myEnumValue;
  }
}
