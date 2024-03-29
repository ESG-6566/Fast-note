import 'package:flutter/material.dart';
import 'package:Fast_note/Item.dart';
import 'package:Fast_note/MyCalculate.dart';
import 'package:Fast_note/MyTheme.dart';
import 'package:Fast_note/main.dart';

class ListElemnt extends StatefulWidget {
  final Item _item;
  final VoidCallback _showChanges;

  ListElemnt({Key? key, required Item item, required VoidCallback showChanges})
      : this._item = item,
        _showChanges = showChanges,
        super(key: key);

  @override
  _ListElemnt createState() => _ListElemnt();
}

class _ListElemnt extends State<ListElemnt> {
  late bool isAvailable = widget._item.isAvailable;
  late int daysAgo =
      MyCalculate.daysBetween(widget._item.dateTime, MyCalculate.currentDate());
  late String dateText = daysAgo == 0 ? 'today' : "${daysAgo}" + "days ago";

  ///change availty of item and widget color
  void _chaingeStatus() {
    widget._item.isAvailable = !widget._item.isAvailable;
    widget._item.dateTime = MyCalculate.currentDate();
    daysAgo = MyCalculate.daysBetween(
        widget._item.dateTime, MyCalculate.currentDate());
    dateText = daysAgo == 0 ? 'today' : "${daysAgo}" + "days ago";
    ;
    //apply list changes to list view
    widget._showChanges();
    //Save new datas of items
    MyHomePage.saveData();
  }

  //delete button select event to delete current item
  void _delet() {
    MyHomePage.items.remove(widget._item);
    MyHomePage.saveData();
    widget._showChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
        decoration: BoxDecoration(
            color: widget._item.isAvailable
                ? MyTheme.backgroundHigher
                : MyTheme.highlight),
        child: InkWell(
          onTap: () {
            setState(() {
              _chaingeStatus();
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget._item.name,
                    textAlign: TextAlign.center,
                    textDirection: MyCalculate.isArabic(widget._item.name)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    style: TextStyle(fontSize: 18.0, color: MyTheme.text),
                  ),
                ),
                Expanded(
                  child: Text(
                    dateText,
                    textAlign: TextAlign.center,
                    textDirection: MyCalculate.isArabic(dateText)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    style: TextStyle(fontSize: 18.0, color: MyTheme.text),
                  ),
                ),
                IconButton(
                  onPressed: _delet,
                  icon: const Icon(Icons.delete),
                  color: MyTheme.text,
                )
              ],
            ),
          ),
        ));
  }
}
