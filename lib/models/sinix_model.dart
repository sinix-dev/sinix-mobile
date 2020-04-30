import 'package:flutter/material.dart';

class UserModel {
  int _uid;
  Color _color;
  
  UserModel(Map<String, dynamic> dataObj){
    this._uid = dataObj["uid"];
    this._color = Color(dataObj["color"]);
  }

  int get uid => _uid;
  Color get color => _color;
}
