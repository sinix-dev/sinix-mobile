import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:hive/hive.dart';

import '../blocs/blocs.dart';
import '../utils/config.dart';
import '../models/controller.dart';

import 'controller/index.dart';
import 'controller/joystick.dart';
import 'controller/quad_group.dart';

class ControllerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder<List<ControllerModel>>(
        stream: Blocs.controllerBloc.controller,
        initialData: [],
        builder: (context, snapshot) {
          var _index = 0;
          var widgets = snapshot.data!.map(
            (controller) {
              return Positioned(
                top: controller.position.dy,
                left: controller.position.dx,
                child: Hero(
                  tag: "controller_widget_$_index",
                  child: ControllerWidget(
                    controller: controller,
                  ),
                ),
              );
            },
          ).toList();

          return Stack(
            children: <Widget>[
              ...widgets,
              Positioned(
                right: 100,
                top: 40,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ConfigWidget.of(context).getTheme().rightPadBgColor,
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: GestureDetector(
                    child: Icon(
                      FeatherIcons.settings,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/edit_controller');
                    },
                  ),
                ),
              ),
            ],
            fit: StackFit.expand,
          );
        },
      ),
    );
  }

  _buildWidget(BuildContext context, int index) {
    return Container();
    var bleh = [
      Positioned(
        right: 100,
        top: 40,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ConfigWidget.of(context).getTheme().rightPadBgColor,
            borderRadius: BorderRadius.circular(90),
          ),
          child: GestureDetector(
            child: Icon(
              FeatherIcons.settings,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/edit_controller');
            },
          ),
        ),
      ),
      Positioned(
        bottom: 10,
        left: 10,
        child: Hero(
          tag: "joypad",
          child: Container(),
        ),
      ),
      Positioned(
        bottom: 10,
        right: 10,
        child: Hero(
          tag: "rightpad",
          child: Container(),
        ),
      ),
    ];
  }
}
