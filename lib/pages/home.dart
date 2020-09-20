import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sinix_android/pages/game.dart';


class HomePage extends StatelessWidget {
  Widget build(BuildContext context){
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          body: Container(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 28.0
                    ),
                    Text(
                      "SINIX",
                      style: TextStyle(
                        fontSize: 80.0
                      )
                    ),
                    SizedBox(
                      height: 34.0
                    ),
                    SizedBox(
                      width: 300.0,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "IP Address"
                        )
                      )
                    ),
                    SizedBox(
                      height: 20.0
                    ),
                    RaisedButton(
                      child: Text("Get In"),
                      onPressed: (){
                        Get.to(GamePage());
                      }
                    )
                  ]
                )
              )
            )
          )
        )
      )
    );
  }
}
