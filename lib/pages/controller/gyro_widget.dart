import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import '../../blocs/blocs.dart';
import '../../models/controller.dart';

class GyroWidget extends StatefulWidget {
  final ControllerModel controller;

  const GyroWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  
  @override
  _GyroWidgetState createState() => _GyroWidgetState();
}

class _GyroWidgetState extends State<GyroWidget> {
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
    return Container(
      child: SizedBox(),
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
