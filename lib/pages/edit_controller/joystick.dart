import 'package:flutter/material.dart';

import '../../models/controller.dart';

class JoystickWidget extends StatefulWidget {
  final ControllerModel controller;

  const JoystickWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  JoystickWidgetState createState() => JoystickWidgetState();
}

class JoystickWidgetState extends State<JoystickWidget> {
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 180,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor.withOpacity(0.35),
            borderRadius: BorderRadius.circular(90),
          ),
          child: Center(
            child: SizedBox(
              height: 70,
              width: 70,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
