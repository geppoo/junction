import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../junction_model.dart';
import 'junction_widget_settings_repository.dart';

///Main model for the Junction Widgets
class JunctionWidgetModel extends StatefulWidget {
  final String? token;
  final List<String>? list;

  final String id;
  final Widget junctionContentWidget;
  final double height;
  final double width;
  final String title;
  final bool visible;

  const JunctionWidgetModel(
      {super.key,
      required this.id,
      required this.junctionContentWidget,
      required this.height,
      required this.width,
      required this.title,
      this.token,
      this.list,
      required this.visible});

  @override
  State<JunctionWidgetModel> createState() => _StateJunctionWidget();
}

class _StateJunctionWidget extends State<JunctionWidgetModel> {
  late Offset position;
  late bool visible;

  void initWidgetProps(JunctionWidgetPropertiesModel junctionWidgetProps) => {
        setState(() => {
              position = Offset(
                  junctionWidgetProps.offSetX, junctionWidgetProps.offSetY),
              visible = junctionWidgetProps.visible
            })
      };

  void updateWidgetProps(
          String junctionId,
          JunctionWidgetPropertiesModel junctionWidgetProps,
          JunctionModel junctionModel) =>
      {
        if (position.dx != junctionWidgetProps.offSetX ||
            position.dy != junctionWidgetProps.offSetY)
          {
            setState(() => position = Offset(
                junctionWidgetProps.offSetX, junctionWidgetProps.offSetY))
          },
        if (visible != junctionWidgetProps.visible)
          {
            setState(() => visible = junctionWidgetProps.visible),
          },
        saveJunctionWidgetProps(junctionWidgetProps,
            junctionModel.junctionWidgetSettingsRepository.junctionWidgetsProp)
      };

  ///Method to save junctionWidget properties into file
  Future<void> saveJunctionWidgetProps(
      JunctionWidgetPropertiesModel junctionWidgetProp,
      Map<String, JunctionWidgetPropertiesModel> junctionWidgetsProps) async {
    junctionWidgetsProps[junctionWidgetProp.widgetId] = junctionWidgetProp;

    JunctionWidgetPropertiesModel.savePropsToFile(junctionWidgetsProps);
  }

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    final JunctionWidgetPropertiesModel? junctionWidgetProps = junctionModel
        .junctionWidgetSettingsRepository.junctionWidgetsProp[widget.id];

    debugPrint(
        "Widget: ${junctionWidgetProps?.widgetId} isVisible: ${junctionWidgetProps?.visible}");

    //Read offSet values from props file
    initWidgetProps(junctionWidgetProps!);

    debugPrint(
        "Widget ${widget.id} state isVisible $visible \n#######################################");

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
                  child: widget.junctionContentWidget,
                ),
                childWhenDragging: Text(widget.title),
                onDragEnd: (details) => {
                  junctionWidgetProps.offSetX = details.offset.dx,
                  junctionWidgetProps.offSetY = details.offset.dy,
                  updateWidgetProps(
                      widget.id, junctionWidgetProps, junctionModel)
                },
                child: Material(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () => {
                          junctionWidgetProps.visible = false,
                          updateWidgetProps(
                              widget.id, junctionWidgetProps, junctionModel)
                        },
                        icon: const Icon(Icons.close),
                        iconSize: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: widget.width,
              height: widget.height - 20,
              color: Colors.grey,
              //clipBehavior: Clip.hardEdge,
              child: widget.junctionContentWidget,
            ),
          ],
        ),
      ),
    );
  }
}
