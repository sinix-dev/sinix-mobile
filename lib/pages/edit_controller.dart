import 'dart:collection';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/controller.dart';
import '../utils/config.dart';
import '../blocs/blocs.dart';

import 'controller/index.dart';
import 'controller/joystick.dart';
import 'controller/quad_group.dart';

class EditController extends StatefulWidget {
  @override
  _EditControllerState createState() => _EditControllerState();
}

class _EditControllerState extends State<EditController> {
  final Box<ControllerModel> controllerBox =
      Hive.box<ControllerModel>("controllerWidgets");

  Offset joypadOffset = Offset(
    10,
    10,
  );

  Offset rightpadOffset = Offset(
    60,
    15,
  );

  void setInitialOffset() {
    joypadOffset = controllerBox.getAt(0)!.position;

    rightpadOffset = Offset(
      60,
      15,
    );
  }

  @override
  void initState() {
    setInitialOffset();
    super.initState();
  }

  void updateDelta(Offset newDelta) {
    setState(() {
      joypadOffset = newDelta;
    });
  }

  void calculateDelta(
    Offset offset,
    Offset local,
    Offset delta,
  ) {
    Offset newDelta = joypadOffset.translate(delta.dx, delta.dy);
    updateDelta(
      newDelta,
    );
  }

  void onDragUpdate(DragUpdateDetails d) {
    calculateDelta(
      d.globalPosition,
      d.localPosition,
      d.delta,
    );
  }

  void onDragEnd(int _index, ControllerModel controller) {
    Blocs.controllerBloc.update(_index, controller);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: StreamBuilder<List<ControllerModel>>(
            stream: Blocs.controllerBloc.controller,
            initialData: [],
            builder: (context, snapshot) {
              var _index = 0;
              var widgets = snapshot.data!.map((controller) {
                _index++;
                return AnimatedPositioned(
                  top: joypadOffset.dy,
                  left: joypadOffset.dx,
                  duration: Duration(milliseconds: 30),
                  child: GestureDetector(
                    child: Hero(
                      tag: "controller_widget_$_index",
                      child: ControllerWidget(
                        controller: controller,
                      ),
                    ),
                    onPanUpdate: onDragUpdate,
                    onPanEnd: (details) {
                      controller = ControllerModel(
                        widgetType: controller.widgetType,
                        position: ControllerOffset.from(joypadOffset),
                      );
                      onDragEnd(_index, controller);
                    },
                  ),
                );
              }).toList();

              return Stack(
                children: [
                  ...widgets,
                  Positioned(
                    right: 100,
                    top: 40,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            ConfigWidget.of(context).getTheme().rightPadBgColor,
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: GestureDetector(
                        child: Icon(
                          FeatherIcons.settings,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          var box = await Hive.openBox<ControllerModel>(
                              "controllerWidgets");

                          box.put(
                            "quad_group_0",
                            ControllerModel(
                              widgetType: ControllerWidgetType.QUAD_GROUP,
                              position: ControllerOffset.from(joypadOffset),
                            ),
                          );

                          var controller =
                              box.get("quad_group_0") as ControllerModel;

                          print(controller.position);
                        },
                      ),
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
              );
            }),
      ),
    );
  }
}
