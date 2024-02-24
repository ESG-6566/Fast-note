import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_test2/AddItem.dart';
import 'package:flutter_application_test2/Item.dart';
import 'package:flutter_application_test2/ListElemnt.dart';
import 'package:flutter_application_test2/MyCalculate.dart';
import 'package:flutter_application_test2/MyTheme.dart';
import 'package:flutter_application_test2/UserData.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  onStart();

  runApp(const MyApp());
}

///load datas in start time of application
Future<void> onStart() async {
  //check for user data file exist
  Directory supportDirectory = await getApplicationSupportDirectory();
  File file = File('${supportDirectory.path}/UserData.json');
  if (file.existsSync()) {
    String json =
        File('${supportDirectory.path}/UserData.json').readAsStringSync();
    Map<String, dynamic> data = jsonDecode(json);

    MyTheme.Switch(MyCalculate.stringToThemeMode(data['themeMode']));
  } else {
    Map<String, dynamic> data = {
      'themeMode': UserData.currentTheme.toString(),
    };
    String json = jsonEncode(data);
    File('${supportDirectory.path}/UserData.json').writeAsStringSync(json);
  }

  //check for items data file exist
  file = File('${supportDirectory.path}/Items.json');
  if (file.existsSync()) {
    //load all items saved in application support folder
    MyHomePage.loadData();
  } else {
    file.createSync();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: MyTheme.colorB,
        textSelectionTheme:
            TextSelectionThemeData(selectionColor: MyTheme.colorB),
        scaffoldBackgroundColor: MyTheme.background,
      ),
      home: const MyHomePage(title: 'Fast note'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  static List<Item> items = [];

  ///Save items datas and changes
  static Future<void> saveData() async {
    String jsonData = jsonEncode(items);
    Directory directory = await getApplicationSupportDirectory();
    String directoryPath = directory.path;
    File('$directoryPath/Items.json').writeAsStringSync(jsonData);
  }

  ///load items datas and changes
  static Future<void> loadData() async {
    // String jsonData = jsonEncode(items);
    Directory directory = await getApplicationSupportDirectory();
    String directoryPath = directory.path;
    String jsonData = File('$directoryPath/Items.json').readAsStringSync();
    items =
        jsonDecode(jsonData).map<Item>((json) => Item.fromJson(json)).toList();
  }

  ///make beter list order for use
  static void updateListOrder() {
    for (int i = 0; i < items.length; i++) {
      if (!items[i].isAvailable) {
        Item current = items.removeAt(i);
        items.insert(0, current);
      }
    }
    saveData();
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///apply list changes to list view
  void showListChanges() {
    setState(() {
      MyHomePage.updateListOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            color: MyTheme.text,
          ),
        ),
        iconTheme: IconThemeData(
          color: MyTheme.text,
        ),
        backgroundColor: MyTheme.noColor,
        actions: [
          IconButton(
            icon: UserData.currentTheme == MyThemeMode.defaultMode
                ? Icon(Icons.dark_mode)
                : Icon(Icons.light_mode),
            color: MyTheme.text,
            onPressed: () {
              setState(() {
                UserData.currentTheme == MyThemeMode.defaultMode
                    ? MyTheme.Switch(MyThemeMode.dark)
                    : MyTheme.Switch(MyThemeMode.defaultMode);
              });
            },
          ),
        ],
      ),
      //bottomSheet: ElevatedButton(onPressed: (() => {}), child: Text("test")),
      body: ListView.separated(
        itemCount: MyHomePage.items.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 2);
        },
        itemBuilder: (context, index) {
          return ListElemnt(
            item: MyHomePage.items[index],
            showChanges: showListChanges,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => AddItemWindow.openScreen(context, showListChanges)),
        tooltip: 'Add items',
        child: const Icon(Icons.add),
        backgroundColor: MyTheme.colorB,
        foregroundColor: MyTheme.buttonText,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
