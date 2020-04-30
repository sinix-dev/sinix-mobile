import 'package:flutter/material.dart';

class EnterPage extends StatefulWidget {
  @override
  _EnterPageState createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  final ipController = TextEditingController();

  @override
  void dispose(){
    ipController.dispose();
    super.dispose();
  }

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
                    controller: ipController,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: (){
                    print(ipController.text);
                  },
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
