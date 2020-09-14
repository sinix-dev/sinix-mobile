import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:sinix_android/pages/home.dart';
import 'package:sinix_android/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(Store());
  Store.to.createConnection();

  // set preferred orientations (landscape only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // disable all UI overlays (show fullscreen)
  await SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(HomePage());
}
