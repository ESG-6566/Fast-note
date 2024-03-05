import 'package:Fast_note/MyTheme.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Widget _nextScreen;

  const LoadingScreen({super.key, required nextScreen}) : _nextScreen = nextScreen;

  // Simulate loading data asynchronously
  Future<void> _loadData() async {
    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: MyTheme.colorB,),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return _nextScreen;
          }
        },
      ),
    );
  }
}
