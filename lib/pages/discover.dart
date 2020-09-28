import 'package:flutter/material.dart';
import 'package:sinix_android/utils/sinix.dart';
import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

class DiscoverDevices extends StatefulWidget {
  @override
  _DiscoverDevicesState createState() => _DiscoverDevicesState();
}

class _DiscoverDevicesState extends State<DiscoverDevices> {
  var DeviceList = [];

  void scan() async {
    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 41431;

    final stream = NetworkAnalyzer.discover2(subnet, port);

    DeviceList = [];

    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');

        setState(() {
          DeviceList.add(addr.ip);
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
    return Container(
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
                  itemCount: DeviceList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      DeviceList[index],
                      style: TextStyle(
                        color: Sinix.textColor,
                        fontSize: 18,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
