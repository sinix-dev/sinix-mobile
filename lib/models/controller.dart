import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'controller.g.dart';

@HiveType(typeId: 1)
enum ControllerWidgetType {
  @HiveField(0)
  JOYSTICK,

  @HiveField(1)
  QUAD_GROUP,

  @HiveField(2)
  BUTTON,

  @HiveField(3)
  GYRO_WIDGET
}

@HiveType(typeId: 2)
class ControllerOffset extends Offset {
  @HiveField(0)
  final double dx;

  @HiveField(1)
  final double dy;

  const ControllerOffset(this.dx, this.dy) : super(dx, dy);

  static ControllerOffset from(Offset offset) {
    return ControllerOffset(offset.dx, offset.dy);
  }
}

@HiveType(typeId: 0)
class ControllerModel {
  @HiveField(0)
  final ControllerWidgetType widgetType;

  @HiveField(1)
  ControllerOffset position;

  ControllerModel({
    required this.widgetType,
    required this.position,
  });
}
