import 'package:flutter/material.dart';

class PauseButton extends StatefulWidget {
  @override
  _PauseButtonState createState() => _PauseButtonState();
}

class _PauseButtonState extends State<PauseButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Pause'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFDC143C)),
        ),
      ),
    );
  }
}
