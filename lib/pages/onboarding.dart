import "package:flutter/material.dart";

import '../blocs/blocs.dart';

class OnBoardingPage extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: StreamBuilder<String>(
                  stream: Blocs.themeBloc.theme,
                  builder: (context, snapshot) {
                    var _theme = "light";
                    if (snapshot.hasData) {
                      _theme = snapshot.data!;
                    }

                    return Image.asset(
                      "assets/$_theme/sinix.png",
                      height: 64,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.12),
                    hintText: "USERNAME",
                    focusColor: Colors.amber,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  print('${controller.text}');

                  Navigator.pushNamed(context, '/discover');
                },
                child: Text(
                  'ENTER',
                  style: TextStyle(color: Theme.of(context).backgroundColor),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).accentColor,
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.fromLTRB(
                      30.0,
                      15.0,
                      30.0,
                      15.0,
                    ),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
