import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sinix_android/pages/discover.dart';
import 'package:sinix_android/utils/store.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with WidgetsBindingObserver {
  final controller = TextEditingController();
  String imageAsset =
      SchedulerBinding.instance.window.platformBrightness == Brightness.light
          ? 'assets/icon/logo_light.png'
          : 'assets/icon/logo_dark.png';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    imageAsset =
        SchedulerBinding.instance.window.platformBrightness == Brightness.light
            ? 'assets/icon/logo_light.png'
            : 'assets/icon/logo_dark.png';
    super.didChangePlatformBrightness();
    setState(() {
      developer.log("rebuilt widget tree");
    });
  }

  @override
  void dispose() {
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Theme.of(context).backgroundColor,
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Image.asset(
                  imageAsset,
                  height: 64,
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 364,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.12),
                      hintText: "USERNAME",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Store.to.saveUserName(controller.text);
                    print('${controller.text}');
                    Get.to(DiscoverDevices());
                  },
                  child: Text(
                    'ENTER',
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
