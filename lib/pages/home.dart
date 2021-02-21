import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinix_android/pages/discover.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: DiscoverDevices()),
    );
  }
}
