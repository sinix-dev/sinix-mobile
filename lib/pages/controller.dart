import 'dart:async';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:sensors/sensors.dart';

import '../blocs/blocs.dart';
import '../utils/config.dart';
import '../models/controller.dart';

import 'controller/index.dart';

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  List<double>? _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    final List<String>? gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    if (gyroscope != null) {
      for (String value in gyroscope) {
        Blocs.channelBloc.udpChannel.add(value);
      }
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder<List<ControllerModel>>(
        stream: Blocs.controllerBloc.controller,
        initialData: [],
        builder: (context, snapshot) {
          var widgets = snapshot.data!.map(
            (controller) {
              return Positioned(
                top: controller.position.dy,
                left: controller.position.dx,
                child: ControllerWidget(
                  controller: controller,
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
                    color: ConfigWidget.of(context)
                        .getTheme()
                        .rightPadBgColor!
                        .withOpacity(0.5),
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

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
  }
}
