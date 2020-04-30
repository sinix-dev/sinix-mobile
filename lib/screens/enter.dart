import 'package:flutter/material.dart';

class EnterPage extends StatefulWidget {
  @override
  _EnterPageState createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: (){},
            child: Text("Connect!"),
          )
        )
      ),
    );
  }
}
