import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sinix_remote/state/index.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print(playerInstance.color);

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RemoteButton("left"),
              SizedBox(
                width: 100
              ),
              RemoteButton("right")
            ]
          )
        ]
      )
    );
  }
}

class RemoteButton extends StatelessWidget {
  final String direction;
  RemoteButton(this.direction);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () async {
        final http.Response response = await http.post(
          "http://${playerInstance.ipAddr}:41431/command",
          body: jsonEncode(<String, String>{
            "data": '{ "payload": { "type": "turn", "value": "${this.direction}", "id": ${playerInstance.id} }, "type": "data" }'
          }),
        );
      },
      child: Container(
        color: playerInstance.color,
        width: 250,
        height: 250,
      )
    );
  }
}
