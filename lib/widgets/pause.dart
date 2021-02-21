import 'package:flutter/material.dart';

class PauseButton extends StatefulWidget {
  final void Function(String) onChange;

  const PauseButton({
    Key key,
    @required this.onChange,
  }) : super(key: key);
  _PauseButtonState createState() => _PauseButtonState();
}

class _PauseButtonState extends State<PauseButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Pause',
          style: TextStyle(color: Theme.of(context).backgroundColor),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
