import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchPanel extends StatefulWidget {
  final List<SwitchButton> actions;

  SwitchPanel({
    GlobalKey key,
    this.actions,
  }) : super(key: key);

  @override
  _SwitchPanelState createState() => _SwitchPanelState();
}

class _SwitchPanelState extends State<SwitchPanel> {
  double position = -30;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 200),
      top: 50,
      left: position,
      child: GestureDetector(
        onTap: () {
          setState(() {
            changeSwitchState();
          });
        },
        child: AnimatedContainer(
          constraints: BoxConstraints(
            minHeight: 50,
          ),
          duration: Duration(milliseconds: 300),
          alignment: Alignment(0.8, 0),
          width: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: (!isExpanded)
              ? Icon(
                  Icons.arrow_forward_ios,
                )
              : Column(
                  children: widget.actions,
                ),
        ),
      ),
    );
  }

  void changeSwitchState() {
    if (!isExpanded) {
      position = 0;
      isExpanded = !isExpanded;
    } else {
      position = -30;
      isExpanded = !isExpanded;
    }
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          position = -30;
          isExpanded = false;
        });
      }
    });
  }
}

class SwitchButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  SwitchButton({this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 8.0),
        child: child,
      ),
    );
  }
}
