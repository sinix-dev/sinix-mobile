import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Player extends GetController {
  Color color;
  int id = 0;
  String ipAddr;

  void init(String payload, String ip){
    final decoded = jsonDecode(payload);
    final colorValue = int.parse("FF${decoded['color']}", radix: 16);

    this.ipAddr = ip;
    this.color = new Color(colorValue);
    this.id = decoded["id"];
  }
}

Player playerInstance = new Player();
