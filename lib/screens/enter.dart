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
        height: 500,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "SINIX",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 70
                    ),
                  )
                ),
                SizedBox(
                  height: 15
                ),
                Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Sinix Game IP Address"
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: (){},
                  child: Text("Connect!"),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
