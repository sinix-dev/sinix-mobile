import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:get/get.dart";
import 'package:web_socket_channel/io.dart';

class User {
  String username;
  bool connected;

  User() {
    this.username = "";
    this.connected = false;
  }

  void connect(String _username) {
    this.connected = true;
    this.username = _username;
  }
}

class Store extends GetxController {
  IOWebSocketChannel channel;
  User user = User();

  static Store get to => Get.find();

  Future<void> createConnection(String ipAddr) async {
    var url = "http://$ipAddr:41431/register";
    var body = {"username": user.username};
   
    await http.post(url, body: body);

    this.user.connect(user.username);
    this.channel =
        IOWebSocketChannel.connect("ws://$ipAddr:41431/ws/${user.username}");
  }
}
