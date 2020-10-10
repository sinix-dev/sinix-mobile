import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sinix_android/utils/store.dart';
import 'package:sinix_android/widgets/joypad.dart';
import 'package:sinix_android/widgets/rightpad.dart';
import 'package:sinix_android/widgets/switch_panel.dart';

class EditController extends StatefulWidget {
  @override
  _EditControllerState createState() => _EditControllerState();
}

class _EditControllerState extends State<EditController> {
  Offset joypadOffset;
  Offset rightpadOffset;

  final localStorage = Store.to.localStorage;

  void setInitialOffset() {
    joypadOffset = Offset(
      double.parse(localStorage.joypadCoordinate[0]),
      double.parse(localStorage.joypadCoordinate[1]),
    );

    rightpadOffset = Offset(
      double.parse(localStorage.rightpadCoordinate[0]),
      double.parse(localStorage.rightpadCoordinate[1]),
    );
  }

  void resetOffset() {
    print("hello");
    joypadOffset = Offset(
      double.parse(localStorage.defaultCoordinate[0]),
      double.parse(localStorage.defaultCoordinate[1]),
    );
    rightpadOffset = Offset(
      double.parse(localStorage.defaultCoordinate[0]),
      double.parse(localStorage.defaultCoordinate[1]),
    );
  }

  @override
  void initState() {
    setInitialOffset();
    super.initState();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Edit Mode",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            bottom: joypadOffset.dy,
            left: joypadOffset.dx,
            child: GestureDetector(
              onPanUpdate: (details) {
                final position = details.globalPosition;
                setState(() {
                  if (position.dx > 30 && position.dx < size.width - 30)
                    joypadOffset = joypadOffset.translate(details.delta.dx, 0);

                  if (position.dy > 90 && position.dy < size.height - 90)
                    joypadOffset = joypadOffset.translate(0, -details.delta.dy);
                });
              },
              child: Container(
                decoration: BoxDecoration(),
                child: AbsorbPointer(
                  child: Hero(
                    tag: "joypad",
                    child: Joypad(onChange: (Offset delta) {}),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            bottom: rightpadOffset.dy,
            right: rightpadOffset.dx,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  final position = details.globalPosition;
                  if (position.dx > 130 && position.dx < size.width - 130)
                    rightpadOffset =
                        rightpadOffset.translate(-details.delta.dx, 0);

                  if (position.dy > 150 && position.dy < size.height - 150)
                    rightpadOffset =
                        rightpadOffset.translate(0, -details.delta.dy);
                });
              },
              child: Container(
                decoration: BoxDecoration(),
                child: AbsorbPointer(
                  child: Hero(
                    tag: "rightpad",
                    child: Rightpad(onChange: (String val) {}),
                  ),
                ),
              ),
            ),
          ),
          SwitchPanel(
            actions: [
              SwitchButton(
                child: Icon(Icons.close,size: 30,),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SwitchButton(
                child: Icon(Icons.save,size: 30,),
                onTap: () async {
                  await localStorage.saveCoordinates(
                      joypadOffset, rightpadOffset);
                  Store.to.update();
                  Get.snackbar("Layout Saved", "");
                },
              ),
              SwitchButton(
                child: Icon(Icons.restore,size: 30,),
                onTap: () {
                  setState(() {
                    resetOffset();
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
