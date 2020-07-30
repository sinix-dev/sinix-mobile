import 'dart:math';
import "package:flutter/material.dart";

class Rightpad extends StatefulWidget {
  final void Function(Offset) onChange;

  const Rightpad({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  RightpadState createState() => RightpadState();
}

class RightpadState extends State<Rightpad> {
  Widget build(BuildContext context){
    return SizedBox(
      height: 200,
      width: 200,
      child: Container(
        color: Colors.black
      )
    );
  }
}
