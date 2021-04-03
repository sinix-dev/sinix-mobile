import 'package:flutter/material.dart';

class SinixTheme {
  final ThemeData themeData;

  final String? assets;
  final String name;
  final Color? borderColor;
  final Color? rightPadBgColor;

  SinixTheme({
    this.assets,
    this.borderColor,
    this.rightPadBgColor,
    required this.name,
    required this.themeData,
  });
}

// Creates the Material Color from given color value
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });

  return MaterialColor(color.value, swatch);
}
