import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:get/get.dart";
import 'package:web_socket_channel/io.dart';

class User {
  String username;
  bool connected;

  User(){
    this.username = "";
    this.connected = false;
  }

  void connect(String _username){
    this.connected = true;
    this.username = _username;
  }
}

class Store extends GetxController {
  IOWebSocketChannel channel;
  User user = User();

  static Store get to => Get.find();

  void createConnection() async {
    var url = "http://192.168.43.226:41431/register";
    var body = {
      "username": "sanket143"
    };

    await http.post(url, body: body);

    this.user.connect("sanket143");
    this.channel = IOWebSocketChannel.connect("ws://192.168.43.226:41431/ws/sanket143");
  }
}
