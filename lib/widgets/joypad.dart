import 'dart:math';
import 'package:flutter/material.dart';

class Joypad extends StatefulWidget {
  final void Function(Offset) onChange;

  const Joypad({
    Key key,
    @required this.onChange,
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
              color: Color(0xFFDC143C).withOpacity(0.35),
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
                      color: Color(0xFFDC143C),
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
