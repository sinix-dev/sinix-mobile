import 'dart:collection';

import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:rxdart/subjects.dart';
import 'package:wifi/wifi.dart';

import 'shared_bloc.dart';

class DiscoverBloc {
  Stream<UnmodifiableListView<NetworkAddress>> get devices =>
      _devicesSubject.stream;
  Stream<bool> get loadingStatus => _loadingStatusSubject.stream;

  final _devicesSubject =
      BehaviorSubject<UnmodifiableListView<NetworkAddress>>();
  final _loadingStatusSubject = BehaviorSubject<bool>.seeded(false);

  List<NetworkAddress> _devices = [];

  Future<Null> getDevices() async {
    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 41430;

    _devices = [];
    _loadingStatusSubject.add(true);

    final stream = NetworkAnalyzer.discover2(subnet, port);

    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');

        _devices.add(addr);
        _devicesSubject.add(UnmodifiableListView(_devices));
      }
    }, onDone: () {
      print("done devices scan");
      _loadingStatusSubject.add(false);
    });
  }

  void connect(String ipAddr) {
    SharedBloc.setDevice(ipAddr);
  }
}
