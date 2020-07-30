import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sinix_remote/widgets/joypad.dart';
import 'package:sinix_remote/widgets/rightpad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set preferred orientations (landscape only)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // disable all UI overlays (show fullscreen)
  await SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          // placeholder for game
          Container(
            color: Color(0xff27ae60),
          ),

          // joypad overlay
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 48),
                  Joypad(
                    onChange: (Offset delta) => print(delta),
                  ),
                  Spacer(),
                  Rightpad(
                    onChange: (Offset delta) => print(delta),
                  ),
                  SizedBox(width: 48),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ],
      ),
    ),
  );
}
