import 'package:flutter/material.dart';
import 'theme.dart';
import 'theme/model.dart';

class ConfigWidget extends InheritedWidget {
  final String currentTheme;

  ConfigWidget({
    @required child,
    this.currentTheme = "light",
  }) : super(child: child);

  @override
  bool updateShouldNotify(ConfigWidget old) {
    return true;
  }

  static ConfigWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ConfigWidget>()!;
  }

  SinixTheme getTheme() {
    return themes[currentTheme]!;
  }
}
