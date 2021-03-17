import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:hive/hive.dart';

import 'blocs/blocs.dart';
import 'utils/theme.dart';
import 'utils/config.dart';
import 'models/controller.dart';

import 'pages/discover.dart';
import 'pages/onboarding.dart';
import 'pages/controller.dart';
import 'pages/edit_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDir.path);

  // set preferred orientations (landscape only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // disable all UI overlays (show fullscreen)
  await SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(App());
}

class App extends StatelessWidget with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: Blocs.themeBloc.theme,
      builder: (context, snapshot) {
        return ConfigWidget(
          currentTheme: snapshot.hasData ? snapshot.data! : "light",
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            routes: {
              "/": (context) => OnBoardingPage(),
              "/discover": (context) => DiscoverPage(),
              "/controller": (context) => ControllerPage(),
              "/edit_controller": (context) => EditController(),
            },
            theme: themes[snapshot.data ?? "light"]?.themeData,
            darkTheme: themes["dark"]?.themeData,
          ),
        );
      },
    );
  }
}
