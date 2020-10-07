import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinix_android/pages/discover.dart';
import 'package:sinix_android/utils/store.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Image.asset('assets/icon/logo_light.png'),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "USERNAME",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                FlatButton(
                  onPressed: () {
                    Store.to.saveUserName(controller.text);
                    print('${controller.text}');
                    Get.to(DiscoverDevices());
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  color: Colors.red[600],
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                  child: Text(
                    'ENTER',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
