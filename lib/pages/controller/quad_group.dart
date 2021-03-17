import 'dart:math';
import "package:flutter/material.dart";

import '../../blocs/blocs.dart';
import '../../models/controller.dart';
import '../../utils/config.dart';

class QuadGroupWidget extends StatelessWidget {
  final ControllerModel controller;

  QuadGroupWidget({
    required this.controller,
  });

  void _onTap(val) {
    Blocs.channelBloc.udpChannel.add(val);
  }

  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4,
      child: SizedBox(
        height: 175,
        width: 175,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RoundButton(
                    name: "Y",
                    onTap: _onTap,
                  ),
                  RoundButton(
                    name: "X",
                    onTap: _onTap,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RoundButton(
                    name: "B",
                    onTap: _onTap,
                  ),
                  RoundButton(
                    name: "A",
                    onTap: _onTap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final void Function(String) onTap;
  final String name;

  RoundButton({
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: ConfigWidget.of(context).getTheme().rightPadBgColor,
            borderRadius: BorderRadius.circular(90),
          ),
          child: SizedBox(
            height: 70,
            width: 70,
            child: Center(
              child: Transform.rotate(
                angle: -pi / 4,
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onTapDown: (val) {
        onTap("B 0 $name 1");
      },
      onTapUp: (val) {
        onTap("B 0 $name 0");
      },
    );
  }
}
