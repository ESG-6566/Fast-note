import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_test2/Item.dart';
import 'package:flutter_application_test2/MyTheme.dart';

class AddItemWindow extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyTheme.background,
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "افزودن مواد",
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                    //color: MyTheme.colorA,
                    border: Border.all(
                      color: MyTheme.colorB,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 500,
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: ' name ...',
                        hintStyle: TextStyle(
                            fontFamily: 'FarKoodak',
                            fontSize: 18.0,
                            color: MyTheme.lowtText),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 20.0),
                        border: InputBorder.none,
                      ),
                      minLines: 1,
                      maxLines: 10,
                      maxLength: 300,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      style: TextStyle(
                        fontFamily: 'FarKoodak',
                        fontSize: 18.0,
                        color: MyTheme.text,
                      ),
                    ),
                  )),
              ElevatedButton(
                  onPressed: () => {
                        _showListChanges(),
                        Item.add(_controller.text),
                        Navigator.pop(context)
                      },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          MyTheme.colorB), // Set button color
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0))), // Maintain padding
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: MyTheme.buttonText,
                        fontSize: 18.0),
                  ))
            ],
          ),
        ));
  }
}
