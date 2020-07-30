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
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Button(name: "Y"),
                Button(name: "X"),
              ]
            ),
            Column(
              children: <Widget>[
                Button(name: "B"),
                Button(name: "A"),
              ]
            ),
          ]
        )
      )
    );
  }
}

class Button extends StatelessWidget {
  final String name;

  Button({
    this.name,
  });

  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x88ffffff),
          borderRadius: BorderRadius.circular(90),
        ),
        child: SizedBox(
          height: 70,
          width: 70,
          child: Center(
            child: Transform.rotate(
              angle: - pi / 4,
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                )
              )
            )
          )
        )
      )
    );
  }
}
