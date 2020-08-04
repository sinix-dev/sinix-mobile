import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:sinix_remote/pages/home.dart';

class Controller extends GetxController {
  IOWebSocketChannel channel;
  var url = "http://192.168.43.226:41431/register";
  var body = {
    "username": "sanket143"
  };

  void createConnection() async {
    var response = await http.post(url, body: body);
    this.channel = IOWebSocketChannel.connect("ws://192.168.43.226:41431/ws/sanket143");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set preferred orientations (landscape only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // disable all UI overlays (show fullscreen)
  await SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(HomePage());
}
