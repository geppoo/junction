import 'package:flutter/material.dart';

///Main model for the Junction Widgets
class JunctionWidgetModel extends StatefulWidget {
  final String? token;
  final List<String>? list;

  final Widget child;
  final double height;
  final String title;
  final double width;
  final double bottom;
  final double left;
  final bool visible;

  const JunctionWidgetModel(
      {super.key,
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

  void updatePosition(Offset newPosition) =>
      setState(() => position = newPosition);

  void hideWidget(bool value) => setState(() => visible = value);

  @override
  Widget build(BuildContext context) {
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
                  onDragEnd: (details) => updatePosition(details.offset),
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
