import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:junction/core/io/file_interface.dart';
import 'package:provider/provider.dart';

import '../junction_model.dart';
import 'junction_widget_settings_repository.dart';

///Main model for the Junction Widgets
class JunctionWidgetModel extends StatefulWidget {
  final String? token;
  final List<String>? list;

  final String id;
  final Widget child;
  final double height;
  final String title;
  final double width;
  final double bottom;
  final double left;
  final bool visible;

  const JunctionWidgetModel(
      {super.key,
      required this.id,
      required this.child,
      required this.height,
      required this.title,
      required this.width,
      required this.left,
      required this.bottom,
      this.token,
      this.list,
      required this.visible});

  @override
  State<JunctionWidgetModel> createState() => _StateJunctionWidget();
}

class _StateJunctionWidget extends State<JunctionWidgetModel> {
  Offset position = const Offset(100, 100);
  bool visible = true;

  void updatePosition(
          String junctionId, Offset newPosition, JunctionModel junctionModel) =>
      {
        setState(() => position = newPosition),
        saveJunctionWidgetPosition(junctionId, newPosition, junctionModel)
      };

  void hideWidget(bool value) => setState(() => visible = value);

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);

    return Visibility(
      visible: visible,
      child: Positioned(
        left: position.dx,
        top: position.dy,
        child: Column(
          children: [
            Container(
              width: widget.width,
              height: 20,
              color: Colors.blueGrey,
              child: Draggable(
                  maxSimultaneousDrags: 1,
                  feedback: Opacity(
                    opacity: 0.8,
                    //TODO Change to parent widget for visualization when dragging
                    child: widget.child,
                  ),
                  childWhenDragging: const Visibility(
                    visible: false,
                    child: Text(""),
                  ),
                  onDragEnd: (details) =>
                      updatePosition(widget.id, details.offset, junctionModel),
                  child: Material(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () => hideWidget(!widget.visible),
                          icon: const Icon(Icons.close),
                          iconSize: 15,
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
              width: widget.width,
              height: widget.height - 20,
              color: Colors.grey,
              //clipBehavior: Clip.hardEdge,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveJunctionWidgetPosition(String junctionId, Offset newPosition,
      JunctionModel junctionModel) async {
    //TODO: access widget file prop, check if exists in prop, if not create else modify
    if (junctionModel
            .junctionWidgetSettingsRepository.junctionWidgetsProp[widget.id] !=
        null) {
      var x = junctionModel.junctionWidgetSettingsRepository
          .junctionWidgetsProp[widget.id]?.offsetX;
      var y = junctionModel.junctionWidgetSettingsRepository
          .junctionWidgetsProp[widget.id]?.offsetY;

      //TODO remove debug
      debugPrint("Old offSet - > X: $x, Y $y \n"
          "New offSet X: ${newPosition.dx}, Y: ${newPosition.dy}");

      junctionModel.junctionWidgetSettingsRepository
          .junctionWidgetsProp[widget.id]?.offsetX = newPosition.dx;
      junctionModel.junctionWidgetSettingsRepository
          .junctionWidgetsProp[widget.id]?.offsetY = newPosition.dy;

      List<JunctionWidgetPropertiesModel> junctionWidgets = [];

      for (var widgetProps in junctionModel
          .junctionWidgetSettingsRepository.junctionWidgetsProp.entries) {
        junctionWidgets.add(widgetProps.value);
      }

      String fileData = "{ \"junctionWidgets\": ${json.encode(junctionWidgets)} }";

      //TODO remove debug
      debugPrint("########## New junction_data.json ########## \n"
          "$fileData");

      //Salvo i dati riguardante il JunctionWidget modificato
      await FileInterface.DATA().writeToFile(fileData);
    }
  }
}
