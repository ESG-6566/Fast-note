import 'package:flutter_application_test2/MyCalculate.dart';
import 'package:flutter_application_test2/main.dart';

class Item {
  late String name;
  bool isAvailable = true;
  late DateTime dateTime;

  Item({required this.name, required this.isAvailable, required this.dateTime});

  Map toJson() => {
        'name': name,
        'isAvailable': isAvailable,
        'dateTime': dateTime.toIso8601String()
      };

  static void add(String name) {
    MyHomePage.items.add(Item(
        name: name, isAvailable: true, dateTime: MyCalculate.currentDate()));
    MyHomePage.updateListOrder();
  }

  Item.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        isAvailable = json['isAvailable'],
        dateTime = DateTime.parse(json['dateTime']);
}
