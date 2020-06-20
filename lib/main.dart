import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sinix_remote/screens/enter.dart';
import 'package:sinix_remote/screens/home.dart';

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

    return GetMaterialApp(
      title: 'Sinix Remote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/enter',
      getPages: [
        GetPage(
          page: () => EnterPage(),
          name: '/enter',
        ),
        GetPage(
          page: () => HomePage(),
          name: '/home',
        ),
      ],
    );
  }
}
