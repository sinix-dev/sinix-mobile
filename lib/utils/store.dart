import 'package:http/http.dart' as http;
import "package:get/get.dart";
import 'package:sinix_android/services/Storage_service.dart';
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

  LocalStorage localStorage = LocalStorage();

  bool isConnectionError = false;

  static Store get to => Get.find();

  Future<void> init() async {
    await localStorage.init();
    localStorage.prefs.setBool('firstOpen', false);
    user.username = localStorage.userName;
  }

  Future<void> saveUserName(String userName) async {
    user.username = userName;
    await localStorage.prefs.setString('userName', userName);
  }

  Future<http.Response> createConnection(
    String ipAddr,
  ) async {
    var url = "http://$ipAddr:41431/register";
    var body = {"username": user.username};

    final response = await http.post(url, body: body).timeout(
      Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
          "Connection Timeout: trying to connect with dead server",
          408,
        );
      },
    ).catchError(
      (error) {
        return http.Response(
          "Connection error: couldn't found server with address: $ipAddr",
          502,
        );
      },
    );

    if (response.statusCode == 200) {
      isConnectionError = false;
      this.user.connect(user.username);
      this.channel = IOWebSocketChannel.connect(
        "ws://$ipAddr:41431/ws/${user.username}",
      );
    } else {
      isConnectionError = true;
    }
    return response;
  }
}
