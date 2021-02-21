import 'package:get/get.dart';
import 'package:wifi/wifi.dart';
import 'package:flutter/material.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

import 'package:sinix_android/utils/sinix.dart';
import 'package:sinix_android/utils/store.dart';
import 'package:sinix_android/pages/game.dart';

class DiscoverDevices extends StatefulWidget {
  @override
  _DiscoverDevicesState createState() => _DiscoverDevicesState();
}

class _DiscoverDevicesState extends State<DiscoverDevices> {
  List<String> deviceList = [];
  bool _isListEmpty = false;

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
    }, onDone: () {
      _refreshController.refreshCompleted();
      if (deviceList.isEmpty) {
        setState(() {
          _isListEmpty = true;
        });
      } else {
        setState(() {
          _isListEmpty = false;
        });
      }
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new Builder(
        builder: (context) => new Container(
          color: Theme.of(context).backgroundColor,
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
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: MaterialClassicHeader(
                        color: Colors.blue,
                      ),
                      controller: _refreshController,
                      onRefresh: scan,
                      child: _isListEmpty
                          ? Text(
                              'No Sinix servers found',
                              style: TextStyle(fontSize: 17),
                            )
                          : ListView.builder(
                              itemCount: deviceList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Device(deviceList[index]);
                              },
                            ),
                    ),
                  ),
                ],
              ),
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
      child: Row(
        children: <Widget>[
          Icon(FeatherIcons.cast),
          SizedBox(
            width: 10.0,
          ),
          Text(
            ipAddr,
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
      onTap: () async {
        final response = await Store.to.createConnection(ipAddr);
        if (response.statusCode == 200) {
          Get.to(GamePage(), arguments: ipAddr);
        } else {
          if (response.statusCode == 408) {
            Get.snackbar(
              'Connection Timeout',
              'Selected server maybe dead!',
            );
          } else if (response.statusCode == 502) {
            Get.snackbar(
              'Connection Error',
              'Couldn\'t found server with address: $ipAddr',
            );
          }
        }
      },
    );
  }
}
