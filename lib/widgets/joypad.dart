import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:udp/udp.dart';

class Joypad extends StatefulWidget {
  final void Function(Offset) onChange;
  final ipAddr;

  const Joypad({
    Key key,
    @required this.onChange,
    @required this.ipAddr,
  }) : super(key: key);

  JoypadState createState() => JoypadState();
}

class JoypadState extends State<Joypad> {
  Offset delta = Offset.zero;

  void updateDelta(Offset newDelta) {
    widget.onChange(newDelta);
    setState(() {
      delta = newDelta;
    });
  }

  void calculateDelta(Offset offset) {
    Offset newDelta = offset - Offset(90, 90);
    updateDelta(
      Offset.fromDirection(
        newDelta.direction,
        min(60, newDelta.distance),
      ),
    );
  }

  void sendDelta(Offset offset) async {
    var sender = await UDP.bind(Endpoint.multicast(InternetAddress(widget.ipAddr), port: Port(41431)));
    await sender.send('JOYSTICK 01 ${offset.dx} ${offset.dy}'.codeUnits,
        Endpoint.broadcast(port: Port(41431)));
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 180,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
        ),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(90),
            ),
            child: Center(
              child: Transform.translate(
                offset: delta,
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
            ),
          ),
          onPanDown: onDragDown,
          onPanUpdate: onDragUpdate,
          onPanEnd: onDragEnd,
        ),
      ),
    );
  }

  void onDragDown(DragDownDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragUpdate(DragUpdateDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragEnd(DragEndDetails d) {
    updateDelta(Offset.zero);
  }
}
