import 'package:flutter/material.dart';
import 'package:sinix_android/widgets/switch_panel.dart';

enum WidgetType {
  stack,
  container,
  positioned,
  hero,
  align,
  text,
  switchButton,
  switchPanel
}

class WidgetBuilder {
  static Widget getWidget(Map<String, dynamic> props) {
    switch (_getWidgetType(props["widgetType"].toString())) {
      case WidgetType.align:
        return _alignWidget(props["props"]);
        break;
      case WidgetType.container:
        return _containerWidget(props["props"]);
        break;
      case WidgetType.hero:
        return _heroWidget(props["props"]);
        break;
      case WidgetType.positioned:
        return _positionedWidget(props["props"]);
        break;
      case WidgetType.stack:
        return _stackWidget(props["props"]);
        break;
      case WidgetType.text:
        return _textWidget(props["props"]);
        break;
      case WidgetType.switchButton:
        return _switchButtonWidget(props["props"]);
        break;
      case WidgetType.switchPanel:
        return _switchPanelWidget(props["props"]);
        break;
      default:
        return null;
    }
  }

  static WidgetType _getWidgetType(String widgetType) {
    switch (widgetType) {
      case "Align":
        return WidgetType.align;
        break;
      case "Container":
        return WidgetType.container;
        break;
      case "Hero":
        return WidgetType.hero;
        break;
      case "Positioned":
        return WidgetType.positioned;
        break;
      case "Stack":
        return WidgetType.stack;
        break;
      case "Text":
        return WidgetType.text;
        break;
      case "SwitchPanel":
        return WidgetType.switchPanel;
        break;
      case "SwitchButton":
        return WidgetType.switchButton;
        break;
      default:
        return null;
    }
  }

  static Align _alignWidget(Map<String, dynamic> props) {
    return Align(
      alignment: _getAlignment(props["alignment"]),
      child: getWidget(props["child"]),
    );
  }

  static Container _containerWidget(Map<String, dynamic> props) {
    return Container(
      alignment: _getAlignment(props["alignment"]),
      child: getWidget(props["child"]),
      color: props["decoration"] != null
          ? null
          : _getColor(props["color"].toString()),
      decoration: _getBoxDecoration(props["decoration"]),
      height: _getDouble(props["height"].toString()),
      width: _getDouble(props["width"].toString()),
      margin: _getEdgeInsets(props["margin"]),
      padding: _getEdgeInsets(props["padding"]),
    );
  }

  static Hero _heroWidget(Map<String, dynamic> props) {
    return Hero(
      tag: props["tag"].toString(),
      child: getWidget(props["child"]),
    );
  }

  static Positioned _positionedWidget(Map<String, dynamic> props) {
    return Positioned(
      child: getWidget(props["child"]),
      bottom: _getDouble(props["bottom"].toString()),
      height: _getDouble(props["height"].toString()),
      left: _getDouble(props["left"].toString()),
      right: _getDouble(props["right"].toString()),
      top: _getDouble(props["top"].toString()),
      width: _getDouble(props["width"].toString()),
    );
  }

  static Stack _stackWidget(Map<String, dynamic> props) {
    return Stack(
      alignment: _getAlignment(props["alignment"].toString()),
      children: _childrenWidget(props["children"]),
    );
  }

  static Text _textWidget(Map<String, dynamic> props) {
    return Text(
      props["text"] ?? "",
      style: _getTextStyle(props["style"]),
    );
  }

  static TextStyle _getTextStyle(Map<String, dynamic> props) {
    return TextStyle(
      color: _getColor(props["color"].toString()),
      fontSize: _getDouble(props["fontSize"].toString()),
    );
  }

  static SwitchPanel _switchPanelWidget(Map<String, dynamic> props) {
    return SwitchPanel(
      actions: _childrenWidget(props["actions"]),
    );
  }

  static SwitchButton _switchButtonWidget(Map<String, dynamic> props) {
    return SwitchButton(
      child: getWidget(props["child"]),
      onTap: props["onTap"],
    );
  }

  static List<Widget> _childrenWidget(List<Map<String, dynamic>> list) {
    return list.map<Widget>((props) => getWidget(props)).toList();
  }

  static Alignment _getAlignment(String alignment) {
    switch (alignment) {
      case "bottomCenter":
        return Alignment.bottomCenter;
      case "bottomLeft":
        return Alignment.bottomLeft;
      case "bottomRight":
        return Alignment.bottomRight;
      case "center":
        return Alignment.center;
      case "centerLeft":
        return Alignment.centerLeft;
      case "centerRight":
        return Alignment.centerRight;
      case "topCenter":
        return Alignment.topCenter;
      case "topLeft":
        return Alignment.topLeft;
      case "topRight":
        return Alignment.topRight;
      default:
        return null;
    }
  }

  static Color _getColor(String color) {
    int c = int.tryParse("0xff" + color.substring(1));
    return c != null ? Color(c) : null;
  }

  static BoxDecoration _getBoxDecoration(Map<String, dynamic> props) {
    return BoxDecoration();
  }

  static EdgeInsets _getEdgeInsets(Map<String, dynamic> props) {
    return EdgeInsets.only(
      bottom: _getDouble(props["bottom"].toString()),
      left: _getDouble(props["left"].toString()),
      right: _getDouble(props["right"].toString()),
      top: _getDouble(props["top"].toString()),
    );
  }

  static double _getDouble(String d) {
    return double.tryParse(d);
  }

  static int _getInt(String i) {
    return int.tryParse(i);
  }
}
