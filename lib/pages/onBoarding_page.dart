import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinix_android/pages/discover.dart';
import 'package:sinix_android/utils/store.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
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
                  height: 60,
                ),
                Icon(
                  Icons.account_circle,
                  size: 105,
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    onSubmitted: (value) {
                      Store.to.user.username = value;
                      Get.to(DiscoverDevices());
                    },
                    decoration: InputDecoration(
                      labelText: "Enter Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
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
