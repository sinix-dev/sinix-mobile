import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences prefs;

  bool firstOpen;
  String userName = "";

  List<String> joypadCoordinate;
  List<String> rightpadCoordinate;
  List<String> pauseBtnCoordinate;

  final List<String> defaultCoordinate = ["40.0", "30.0"];

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    firstOpen = prefs.getBool('firstOpen') ?? true;
    userName = prefs.getString('userName') ?? "";

    getCoordinates();
  }

  void getCoordinates() {
    joypadCoordinate =
        prefs.getStringList("joypadCoordinate") ?? defaultCoordinate;
    rightpadCoordinate =
        prefs.getStringList("rightpadCoordinate") ?? defaultCoordinate;
    pauseBtnCoordinate =
        prefs.getStringList("pauseBtnCoordinate") ?? defaultCoordinate;
  }

  Future<void> saveCoordinates(
      Offset joypadCoordinate,
      Offset rightpadCoordinate,
      Offset pauseBtnCoordinate) async {
    this.joypadCoordinate[0] = joypadCoordinate.dx.toString();
    this.joypadCoordinate[1] = joypadCoordinate.dy.toString();

    this.rightpadCoordinate[0] = rightpadCoordinate.dx.toString();
    this.rightpadCoordinate[1] = rightpadCoordinate.dy.toString();

    this.pauseBtnCoordinate[0] = pauseBtnCoordinate.dx.toString();
    this.pauseBtnCoordinate[1] = pauseBtnCoordinate.dy.toString();

    await prefs.setStringList("joypadCoordinate", this.joypadCoordinate);
    await prefs.setStringList("rightpadCoordinate", this.rightpadCoordinate);
    await prefs.setStringList("pauseBtnCoordinate", this.pauseBtnCoordinate);
  }
}
