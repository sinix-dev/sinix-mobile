import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

import '../models/controller.dart';

class ControllerBloc {
  Stream<List<ControllerModel>> get controller => _controller.stream;

  final _controller = BehaviorSubject<List<ControllerModel>>.seeded([]);
  final _defaultControllerSetup = [
    ControllerModel(
      position: ControllerOffset(440, 140),
      widgetType: ControllerWidgetType.QUAD_GROUP,
    ),
    ControllerModel(
      position: ControllerOffset(130, 140),
      widgetType: ControllerWidgetType.JOYSTICK,
    ),
  ];

  ControllerBloc() {
    Hive.registerAdapter(ControllerModelAdapter());
    Hive.registerAdapter(ControllerOffsetAdapter());
    Hive.registerAdapter(ControllerWidgetTypeAdapter());

    init();
    update();
  }

  Future<Box<ControllerModel>> box() async {
    Box<ControllerModel> controllerBox;

    try {
      controllerBox = await Hive.openBox<ControllerModel>("controllerWidgets");
    } catch (e) {
      controllerBox = Hive.box<ControllerModel>("controllerWidgets");
    }

    return controllerBox;
  }

  void init() async {
    Box<ControllerModel> controllerBox = await box();

    if (controllerBox.values.length == 0) {
      controllerBox.putAll(_defaultControllerSetup.asMap());
    }
  }

  void update() async {
    Box<ControllerModel> controllerBox = await box();
    List<ControllerModel> controllerStack = [];

    for (var index = 0; index < controllerBox.length; index++) {
      var controller = controllerBox.getAt(index)!;
      controllerStack.add(controller);
    }

    _controller.add(controllerStack);
  }
}
