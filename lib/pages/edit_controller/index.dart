import 'package:flutter/material.dart';

import 'joystick.dart';
import 'quad_group.dart';

import '../../models/controller.dart';

class ControllerWidget extends StatelessWidget {
  final ControllerModel controller;
  ControllerWidget({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    switch (controller.widgetType) {
      case ControllerWidgetType.QUAD_GROUP:
        return QuadGroupWidget(controller: controller);
      case ControllerWidgetType.JOYSTICK:
        return JoystickWidget(controller: controller);
      default:
        return Container();
    }
  }
}
