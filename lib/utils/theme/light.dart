import 'package:flutter/material.dart';

import 'model.dart';

final SinixTheme lightTheme = SinixTheme(
  name: "light",
  assets: "assets/light",
  borderColor: Color(0xFF000000),
  rightPadBgColor: Color(0xFFDC143C),
  themeData: ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    canvasColor: Colors.white,
    backgroundColor: Colors.white,
    accentColor: Color(0xFFDC143C),
    primaryColor: Color(0xFFDC143C),
    secondaryHeaderColor: Colors.black,
  ),
);
