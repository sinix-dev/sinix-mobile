import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:udp/udp.dart';

import 'shared_bloc.dart';

class ChannelBloc {
  BehaviorSubject<String> get udpChannel => _udp;

  final _udp = BehaviorSubject<String>();

  ChannelBloc() {
    init();
  }

  void init() async {
    final sender = await UDP.bind(Endpoint.any(port: Port(41432)));

    _udp.listen((value) async {
      var ipAddr = SharedBloc.connectedDeviceIp;
      var endpoint =
          Endpoint.multicast(InternetAddress(ipAddr), port: Port(41431));
      var dataLength = await sender.send(value.codeUnits, endpoint);
      print(dataLength);
    });
  }
}
