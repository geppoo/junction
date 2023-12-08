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
  final bool visible;

  const JunctionWidgetModel(
      {super.key,
      required this.id,
      required this.child,
      required this.height,
      required this.title,
      required this.width,
      this.token,
      this.list,
      required this.visible});

  @override
  State<JunctionWidgetModel> createState() => _StateJunctionWidget();
}

class _StateJunctionWidget extends State<JunctionWidgetModel> {
  late Offset position;
  bool visible = true;

  void initPosition(Offset initialPosition) =>
      {setState(() => position = initialPosition)};

  void updatePosition(
          String junctionId, Offset newPosition, JunctionModel junctionModel) =>
      {
        setState(() => position = newPosition),
        saveJunctionWidgetPosition(junctionId, newPosition, junctionModel)
      };

  void hideWidget(bool value) => setState(() => visible = value);

  Future<void> saveJunctionWidgetPosition(String junctionId, Offset newPosition,
      JunctionModel junctionModel) async {
    if (junctionModel
            .junctionWidgetSettingsRepository.junctionWidgetsProp[widget.id] !=
        null) {
      var x = junctionModel.junctionWidgetSettingsRepository
          .junctionWidgetsProp[widget.id]?.offSetX;
      var y = junctionModel.junctionWidgetSettingsRepository
          .junctionWidgetsProp[widget.id]?.offSetY;

      //TODO remove debug
      debugPrint("Old offSet - > X: $x, Y $y \n"
          "New offSet X: ${newPosition.dx}, Y: ${newPosition.dy}");

      junctionModel.junctionWidgetSettingsRepository
          .junctionWidgetsProp[widget.id]?.offSetX = newPosition.dx;
      junctionModel.junctionWidgetSettingsRepository
          .junctionWidgetsProp[widget.id]?.offSetY = newPosition.dy;

      List<JunctionWidgetPropertiesModel> junctionWidgets = [];

      for (var widgetProps in junctionModel
          .junctionWidgetSettingsRepository.junctionWidgetsProp.entries) {
        junctionWidgets.add(widgetProps.value);
      }

      String fileData =
          "{ \"junctionWidgets\": ${json.encode(junctionWidgets)} }";

      //TODO remove debug
      debugPrint("########## NEW junction_data.json ########## \n"
          "$fileData");

      //Salvo i dati riguardante il JunctionWidget modificato
      await FileInterface.DATA().writeToFile(fileData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);

    //Read offSet values from props file
    initPosition(Offset(
        junctionModel.junctionWidgetSettingsRepository
            .junctionWidgetsProp[widget.id]!.offSetX,
        junctionModel.junctionWidgetSettingsRepository
            .junctionWidgetsProp[widget.id]!.offSetY));

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
}
