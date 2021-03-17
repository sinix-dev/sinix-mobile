import 'dart:collection';
import "package:flutter/material.dart";
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

import '../blocs/blocs.dart';

class DiscoverPage extends StatelessWidget {
  DiscoverPage({Key? key}) : super(key: key) {
    Blocs.discoverBloc.getDevices();
    Blocs.discoverBloc.loadingStatus.listen((event) {
      print("Event $event");
      this._isLoading = event;
    });
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              height: 18,
            ),
            StreamBuilder<UnmodifiableListView<NetworkAddress>>(
              stream: Blocs.discoverBloc.devices,
              initialData: UnmodifiableListView<NetworkAddress>([]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return CustomRefreshIndicator(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 100,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data!
                          .map((val) => _buildItem(context, val))
                          .toList(),
                    ),
                  ),
                  builder: (
                    BuildContext context,
                    Widget child,
                    IndicatorController controller,
                  ) {
                    return AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, _) {
                        return Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            if (!controller.isIdle)
                              Positioned(
                                top: 35.0 * controller.value,
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    value: !controller.isLoading
                                        ? controller.value.clamp(0.0, 1.0)
                                        : null,
                                  ),
                                ),
                              ),
                            Transform.translate(
                              offset: Offset(0, 100.0 * controller.value),
                              child: child,
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onRefresh: () async {
                    print("on refresh");
                    Blocs.discoverBloc.getDevices();
                    while (true) {
                      await Future.delayed(Duration(seconds: 1));

                      if (!_isLoading) {
                        break;
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, NetworkAddress addr) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        splashColor: Color(0x00FFFFFF),
        highlightColor: Color(0x00FFFFFF),
        child: Row(
          children: <Widget>[
            Icon(
              FeatherIcons.cast,
              size: 26,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              addr.ip,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
        onTap: () {
          Blocs.discoverBloc.connect(addr.ip);
          Navigator.pushNamed(context, '/controller');
        },
      ),
    );
  }
}
