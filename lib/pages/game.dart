import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinix_android/pages/edit_controller.dart';
import 'package:sinix_android/widgets/pause.dart';
import 'package:sinix_android/widgets/switch_panel.dart';
import 'package:web_socket_channel/io.dart';

import 'package:sinix_android/widgets/joypad.dart';
import 'package:sinix_android/widgets/rightpad.dart';
import 'package:sinix_android/utils/store.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final IOWebSocketChannel channel = Store.to.channel;

  final User user = Store.to.user;

  Offset joypadOffset;

  Offset rightpadOffset;

  Offset pauseButtonOffset;

  final localStorage = Store.to.localStorage;

  void setInitialOffset() {
    joypadOffset = Offset(
      double.parse(localStorage.joypadCoordinate[0]),
      double.parse(localStorage.joypadCoordinate[1]),
    );

    rightpadOffset = Offset(
      double.parse(localStorage.rightpadCoordinate[0]),
      double.parse(localStorage.rightpadCoordinate[1]),
    );

    pauseButtonOffset = Offset(
      double.parse(localStorage.pauseBtnCoordinate[0]),
      double.parse(localStorage.pauseBtnCoordinate[1]),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: Theme.of(context).highlightColor,
          automaticallyImplyLeading: false,
          title: Text(
            "Now playing: Contra II",
            style: TextStyle(
              fontSize: 17.0,
              letterSpacing: 1.1,
              fontFamily: 'Roboto',
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
      body: GetBuilder<Store>(
        builder: (store) {
          setInitialOffset();
          return Directionality(
            textDirection: TextDirection.ltr,
            child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      Container(
                        color: Theme.of(context).backgroundColor,
                      ),

                      // joypad overlay
                      Positioned(
                        bottom: joypadOffset.dy,
                        left: joypadOffset.dx,
                        child: Hero(
                          tag: "joypad",
                          child: Joypad(onChange: (Offset delta) {
                            var resp = {
                              "event_type": "STICK1",
                              "payload": {
                                "x": delta.dx,
                                "y": delta.dy,
                                "username": user.username,
                              }
                            };
                            this.channel.sink.add(jsonEncode(resp));
                          }),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(snapshot.hasData ? "${snapshot.data}" : ""),
                      ),
                      Positioned(
                        bottom: rightpadOffset.dy,
                        right: rightpadOffset.dx,
                        child: Hero(
                          tag: "rightpad",
                          child: Rightpad(onChange: (String val) {
                            var resp = {
                              "event_type": "BUTTON",
                              "payload": {
                                "val": val,
                                "username": user.username,
                              }
                            };
                            this.channel.sink.add(jsonEncode(resp));
                          }),
                        ),
                      ),
                      Positioned(
                        bottom: pauseButtonOffset.dy,
                        right: pauseButtonOffset.dx,
                        child: Hero(
                          tag: "pause",
                          child: PauseButton(onChange: (String val) {}),
                        ),
                      ),
                      SwitchPanel(
                        actions: [
                          SwitchButton(
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Get.to(EditController());
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }),
          );
        },
      ),
    );
  }
}
