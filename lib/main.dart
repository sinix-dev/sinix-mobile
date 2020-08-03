import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:sinix_remote/pages/home.dart';
import 'package:sinix_remote/widgets/joypad.dart';
import 'package:sinix_remote/widgets/rightpad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set preferred orientations (landscape only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // disable all UI overlays (show fullscreen)
  await SystemChrome.setEnabledSystemUIOverlays([]);

  final channel = IOWebSocketChannel.connect('ws://192.168.43.226:41430/sanket143');

  runApp(HomePage());
}
