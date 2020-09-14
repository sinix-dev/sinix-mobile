import 'dart:math' as math;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'package:sinix_android/widgets/joypad.dart';
import 'package:sinix_android/widgets/rightpad.dart';
import 'package:sinix_android/store.dart';

class GamePage extends StatelessWidget {
  IOWebSocketChannel channel = Store.to.channel;
  User user = Store.to.user;

  Widget build(BuildContext context){
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            return Stack(
              children: [
                // placeholder for game
                Container(
                  color: Color(0xFFDC143C),
                ),

                // joypad overlay
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 60),
                        Joypad(
                          onChange: (Offset delta){
                            var resp = {
                              "event_type": "STICK1",
                              "payload": {
                                "x": delta.dx,
                                "y": delta.dy,
                              }
                            };

                            this.channel.sink.add(jsonEncode(resp));
                          }
                        ),
                        Spacer(),
                        Text(snapshot.hasData ? "${snapshot.data}" : ""),
                        Spacer(),
                        Transform.rotate(
                          angle: math.pi / 4,
                          child: Rightpad(
                            onChange: (String val){
                              var resp = {
                                "event_type": "BUTTON",
                                "payload": {
                                  "val": val
                                }
                              };

                              this.channel.sink.add(jsonEncode(resp));
                            }
                          ),
                        ),
                        SizedBox(width: 48),
                      ],
                    ),
                    SizedBox(height: 48),
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
