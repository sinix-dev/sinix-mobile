import 'package:flutter/material.dart';

import 'model.dart';

final SinixTheme darkTheme = SinixTheme(
  name: "dark",
  assets: "assets/dark",
  borderColor: Color(0xFFEEEDED),
  rightPadBgColor: Color(0xFFFFFFFF).withOpacity(0.35),
  themeData: ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    canvasColor: Colors.white,
    backgroundColor: Color(0xFF071521),
    accentColor: Color(0xFFFFFFFF),
    primaryColor: Color(0xFF071521),
    secondaryHeaderColor: Colors.white,
  ),
);
