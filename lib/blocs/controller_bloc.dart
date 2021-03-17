import 'dart:collection';

import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

import '../models/controller.dart';

class ControllerBloc {
  Stream<List<ControllerModel>> get controller => _controller.stream;

  final _controller = BehaviorSubject<List<ControllerModel>>.seeded([]);

  ControllerBloc() {
    Hive.registerAdapter(ControllerModelAdapter());
    Hive.registerAdapter(ControllerOffsetAdapter());
    Hive.registerAdapter(ControllerWidgetTypeAdapter());

    init();
  }

  void init() async {
    var controllerBox =
        await Hive.openBox<ControllerModel>("controllerWidgets");
    List<ControllerModel> controllerStack = [];

    for (var index = 0; index < controllerBox.length; index++) {
      var controller = controllerBox.getAt(index)!;
      controllerStack.add(controller);
    }

    _controller.add(controllerStack);
  }

  void update(int index, ControllerModel controller) {
    var box = Hive.box("controllerWidgets");
    box.put(
      "quad_group_0",
      controller,
    );
  }
}
