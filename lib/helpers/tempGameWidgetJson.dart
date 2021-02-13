Map<String, dynamic> tempWidget = {
  "widgetType": "Stack",
  "props": {
    "children": [
      {
        "widgetType": "Container",
        "props": {
          "color": "#000000",
        },
      },
      {
        "widgetType": "Positioned",
        "props": {
          "bottom": 40.0,
          "left": 30.0,
          "child": {
            "widgetType": "Hero",
            "props": {
              "tag": "joypad",
              "widgetType": "Joypad",
              "props": {},
            },
          }
        },
      },
      {
        "widgetType": "Align",
        "props": {
          "alignment": "bottomCenter",
          "child": {
            "widgetType": "Text",
            "props": {
              "text": "Snapshot Data",
            },
          },
        },
      }
    ],
  },
};
