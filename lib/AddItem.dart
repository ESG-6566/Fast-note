import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Fast_note/Item.dart';
import 'package:Fast_note/MyTheme.dart';
import 'package:Fast_note/main.dart';

class AddItemWindow extends StatefulWidget {
  final VoidCallback _showListChanges;

  AddItemWindow({super.key, required VoidCallback showListChanges})
      : _showListChanges = showListChanges;

  static void openScreen(BuildContext context, VoidCallback showListChanges) {
    // Navigate to a new screen
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddItemWindow(
                showListChanges: showListChanges,
              )),
    );
  }

  @override
  _AddItemWindow createState() => _AddItemWindow();
}

class _AddItemWindow extends State<AddItemWindow> {
  TextEditingController _controller = TextEditingController();
  bool error = false;

  //add button select event
  void add() {
    //check item exist
    for (int i = 0; i < MyHomePage.items.length; i++) {
      if (MyHomePage.items[i].name == _controller.text) {
        setState(() {
          error = true;
        });
        break;
      } else {
        error = false;
      }
    }
    if (!error) {
      widget._showListChanges();
      Item.add(_controller.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyTheme.background,
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Add item",
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'FarKoodak', color: MyTheme.text),
            ),
            backgroundColor: MyTheme.noColor,
            iconTheme: IconThemeData(
              color: MyTheme.text,
            )),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              nameInput(),
              errorText(),
              addButton(),
            ],
          ),
        ));
  }

  Center nameInput() {
    return Center(
        child: Container(
            decoration: BoxDecoration(
              //color: MyTheme.colorA,
              border: Border.all(
                color: MyTheme.colorB,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 500,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: ' name ...',
                  hintStyle: TextStyle(
                      fontFamily: 'FarKoodak',
                      fontSize: 18.0,
                      color: MyTheme.lowtText),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  border: InputBorder.none,
                ),
                minLines: 1,
                maxLines: 10,
                maxLength: 300,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                style: TextStyle(
                  fontSize: 18.0,
                  color: MyTheme.text,
                ),
              ),
            )));
  }

  Visibility errorText() {
    return Visibility(
        visible: error,
        child: Center(
            child: Container(
          width: 500,
          margin: const EdgeInsets.all(8.0),
          child: Text(
            'This item has already been added. Try to change the name',
            style: TextStyle(color: MyTheme.warning),
          ),
        )));
  }

  Center addButton() {
    return Center(
        child: Container(
            margin: EdgeInsets.all(16.0),
            child: ElevatedButton(
                onPressed: () => {
                      add(),
                    },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        MyTheme.colorB), // Set button color
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 20.0))), // Maintain padding
                child: Text(
                  "Add",
                  style: TextStyle(color: MyTheme.buttonText, fontSize: 18.0),
                ))));
  }
}
