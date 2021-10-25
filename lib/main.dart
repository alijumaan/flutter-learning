import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter app'),
        ),
        body: Center(
          child: Text(
            'Hello World',
            style: TextStyle(fontSize: 28),
          ),
        ),
      )
    );
  }
}
