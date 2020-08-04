import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:get/get.dart";
import 'package:web_socket_channel/io.dart';

class User {
  String username;
  bool connected;
  int hue;

  User(){
    this.hue = 0;
    this.username = "";
    this.connected = false;
  }

  void connect(String _username, int _hue){
    this.hue = _hue;
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

    var response = await http.post(url, body: body);
    var payload = jsonDecode(response.body);

    print(payload["hue"]);
    this.user.connect("sanket143", payload["hue"]);

    this.channel = IOWebSocketChannel.connect("ws://192.168.43.226:41431/ws/sanket143");
  }
}
