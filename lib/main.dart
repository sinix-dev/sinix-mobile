import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sinix_remote/screens/enter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      title: 'Sinix Remote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EnterPage(),
    );
  }
}