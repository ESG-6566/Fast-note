import 'dart:convert';
import 'dart:io';

import 'package:Fast_note/MyTheme.dart';
import 'package:path_provider/path_provider.dart';

///this class is for managing user main datas
class UserData {
  static MyThemeMode currentTheme = MyThemeMode.defaultMode;

  Map toJson() => {
        'themeMode': currentTheme.toString(),
      };

  static Future<void> saveData() async {
    UserData userData = UserData();
    String json = jsonEncode(userData);
    Directory supportDirectory = await getApplicationSupportDirectory();
    File('${supportDirectory.path}/UserData.json').writeAsStringSync(json);
  }
}
