import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences prefs;

  bool firstOpen;
  String userName = "";

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    firstOpen = prefs.getBool('firstOpen') ?? true;
    userName = prefs.getString('userName') ?? "";
  }
}
