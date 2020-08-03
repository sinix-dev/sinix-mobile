class GamePage extends StatelessWidget {
  Widget build(BuildContext context){
    return Directionality(
      textDirection: TextDirection.ltr,
      child: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          return Stack(
            children: [
              // placeholder for game
              Container(
                color: HSLColor.fromAHSL(1.0, 250, 1.0, 0.25).toColor(),
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
                          channel.sink.add(delta.toString());
                        }
                      ),
                      Spacer(),
                      Text(snapshot.hasData ? "${snapshot.data}" : ""),
                      Spacer(),
                      Transform.rotate(
                        angle: math.pi / 4,
                        child: Rightpad(
                          onChange: (Offset delta) => print(delta),
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
    );
  }
}
