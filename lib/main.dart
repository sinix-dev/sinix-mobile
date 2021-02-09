import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sinix_android/helpers/theme.dart';
import 'package:sinix_android/pages/discover.dart';
import 'package:sinix_android/pages/game.dart';
import 'package:sinix_android/pages/onboarding.dart';
import 'package:sinix_android/utils/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set preferred orientations (landscape only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // disable all UI overlays (show fullscreen)
  await SystemChrome.setEnabledSystemUIOverlays([]);

  Get.put(Store());

  await Store.to.init();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      home: Scaffold(
        body: Store.to.localStorage.firstOpen ? OnBoardingPage() : DiscoverDevices(),
      ),
    );
  }
}
