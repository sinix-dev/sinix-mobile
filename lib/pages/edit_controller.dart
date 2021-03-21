import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/controller.dart';
import '../utils/config.dart';
import '../blocs/blocs.dart';

import 'edit_controller/index.dart';

class EditController extends StatefulWidget {
  @override
  _EditControllerState createState() => _EditControllerState();
}

class _EditControllerState extends State<EditController> {
  late Box<ControllerModel> controllerBox;
  List<ControllerModel> controllerModels = [];

  void setup() async {
    controllerBox = await Blocs.controllerBloc.box();

    setState(() {
      controllerModels = controllerBox.values.toList();
    });
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  void onDragUpdate(int index, DragUpdateDetails details) {
    setState(() {
      controllerModels[index].position = ControllerOffset.from(
        controllerModels[index].position.translate(
              details.delta.dx,
              details.delta.dy,
            ),
      );
    });
  }

  void onDragEnd(int index) async {
    print(controllerModels[index].position.toString());
    controllerBox.putAt(
      index,
      controllerModels[index],
    );

    Blocs.controllerBloc.update();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: [
            ...controllerModels
                .asMap()
                .map((index, controller) {
                  return MapEntry(
                      index,
                      AnimatedPositioned(
                        top: controller.position.dy,
                        left: controller.position.dx,
                        duration: Duration(milliseconds: 30),
                        child: GestureDetector(
                          child: ControllerWidget(
                            controller: controller,
                          ),
                          onPanUpdate: (details) {
                            onDragUpdate(index, details);
                          },
                          onPanEnd: (details) {
                            onDragEnd(index);
                          },
                        ),
                      ));
                })
                .values
                .toList(),
            Positioned(
              right: 100,
              top: 40,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ConfigWidget.of(context)
                        .getTheme()
                        .rightPadBgColor!
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: Center(
                    child: Text(
                      "DONE",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                }
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Edit Mode",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
