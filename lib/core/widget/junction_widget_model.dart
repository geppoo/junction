import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../junction_model.dart';
import 'junction_widget_settings_repository.dart';

///Main model for the Junction Widgets
class JunctionWidgetModel extends StatefulWidget {
  final String? token;
  final List<String>? list;

  final JunctionWidgetPropertiesModel widgetProps;

  const JunctionWidgetModel(
      {super.key, this.token, this.list, required this.widgetProps});

  @override
  State<JunctionWidgetModel> createState() => _StateJunctionWidget();
}

class _StateJunctionWidget extends State<JunctionWidgetModel> {
  late Offset position;
  late bool isVisible;
  late double borderRadius = 7.5;

  void initWidgetProps(JunctionWidgetPropertiesModel junctionWidgetProps) => {
        setState(
          () => {
            position = Offset(
                junctionWidgetProps.offSetX, junctionWidgetProps.offSetY),
            isVisible = junctionWidgetProps.visible
          },
        )
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
        if (isVisible != junctionWidgetProps.visible)
          {
            setState(() => isVisible = junctionWidgetProps.visible),
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
        .junctionWidgetSettingsRepository
        .junctionWidgetsProp[widget.widgetProps.widgetId];

    //Read offSet values from props file
    initWidgetProps(junctionWidgetProps!);

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Visibility(
        visible: isVisible,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: widget.widgetProps.width,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius),
                  ),
                ),
                child: Draggable(
                  maxSimultaneousDrags: 1,
                  feedback: Opacity(
                    opacity: 0.8,
                    //TODO Resolve "Incorrect use of ParentDataWidget"
                    child: widget,
                    //child: Text(widget.widgetProps.title),
                  ),
                  childWhenDragging: Material(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () => {
                            junctionWidgetProps.visible = false,
                            updateWidgetProps(widget.widgetProps.widgetId,
                                junctionWidgetProps, junctionModel)
                          },
                          icon: const Icon(Icons.close),
                          iconSize: 15,
                        ),
                      ],
                    ),
                  ),
                  onDragEnd: (details) => {
                    junctionWidgetProps.offSetX = details.offset.dx,
                    junctionWidgetProps.offSetY = details.offset.dy,
                    updateWidgetProps(widget.widgetProps.widgetId,
                        junctionWidgetProps, junctionModel)
                  },
                  child: Material(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () => {
                            junctionWidgetProps.visible = false,
                            updateWidgetProps(widget.widgetProps.widgetId,
                                junctionWidgetProps, junctionModel)
                          },
                          icon: const Icon(Icons.close),
                          iconSize: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: widget.widgetProps.width,
                child: const Divider(
                  color: Colors.black,
                  endIndent: 10,
                  indent: 10,
                  thickness: 2,
                  height: 2,
                ),
              ),
              Container(
                width: widget.widgetProps.width,
                height: widget.widgetProps.height - 20,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(borderRadius),
                    bottomRight: Radius.circular(borderRadius),
                  ),
                ),
                child: Text(widget.widgetProps.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
