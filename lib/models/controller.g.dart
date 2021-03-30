// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ControllerWidgetTypeAdapter extends TypeAdapter<ControllerWidgetType> {
  @override
  final int typeId = 1;

  @override
  ControllerWidgetType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ControllerWidgetType.JOYSTICK;
      case 1:
        return ControllerWidgetType.QUAD_GROUP;
      case 2:
        return ControllerWidgetType.BUTTON;
      default:
        return ControllerWidgetType.JOYSTICK;
    }
  }

  @override
  void write(BinaryWriter writer, ControllerWidgetType obj) {
    switch (obj) {
      case ControllerWidgetType.JOYSTICK:
        writer.writeByte(0);
        break;
      case ControllerWidgetType.QUAD_GROUP:
        writer.writeByte(1);
        break;
      case ControllerWidgetType.BUTTON:
        writer.writeByte(2);
        break;
      case ControllerWidgetType.GYRO_WIDGET:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ControllerWidgetTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ControllerOffsetAdapter extends TypeAdapter<ControllerOffset> {
  @override
  final int typeId = 2;

  @override
  ControllerOffset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ControllerOffset(
      fields[0] as double,
      fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ControllerOffset obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dx)
      ..writeByte(1)
      ..write(obj.dy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ControllerOffsetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ControllerModelAdapter extends TypeAdapter<ControllerModel> {
  @override
  final int typeId = 0;

  @override
  ControllerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ControllerModel(
      widgetType: fields[0] as ControllerWidgetType,
      position: fields[1] as ControllerOffset,
    );
  }

  @override
  void write(BinaryWriter writer, ControllerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.widgetType)
      ..writeByte(1)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ControllerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
