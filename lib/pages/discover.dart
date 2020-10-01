import 'package:get/get.dart';
import 'package:wifi/wifi.dart';
import 'package:flutter/material.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

import 'package:sinix_android/utils/sinix.dart';
import 'package:sinix_android/utils/store.dart';
import 'package:sinix_android/pages/game.dart';

class DiscoverDevices extends StatefulWidget {
  @override
  _DiscoverDevicesState createState() => _DiscoverDevicesState();
}

class _DiscoverDevicesState extends State<DiscoverDevices> {
  var deviceList = [];

  void scan() async {
    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 41431;

    final stream = NetworkAnalyzer.discover2(subnet, port);

    deviceList = [];

    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');

        setState(() {
          deviceList.add(addr.ip);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    this.scan();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Available Devices",
                  style: TextStyle(
                    color: Sinix.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: deviceList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Device(deviceList[index]);
                    },
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

class Device extends StatelessWidget {
  final ipAddr;

  Device(this.ipAddr);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        ipAddr,
        style: TextStyle(
          color: Sinix.textColor,
          fontSize: 18,
        ),
      ),
      onTap: () async {
        // TODO: Add a page or prompt asking for Username
        await Store.to.createConnection(ipAddr);
        Get.to(GamePage());
      },
    );
  }
}
