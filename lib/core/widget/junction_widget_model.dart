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

  const JunctionWidgetModel(
      {super.key,
      required this.child,
      required this.height,
      required this.title,
      required this.width,
      required this.left,
      required this.bottom,
      this.token,
      this.list});

  @override
  State<JunctionWidgetModel> createState() => _StateJunctionWidget();
}

class _StateJunctionWidget extends State<JunctionWidgetModel> {
  Offset position = const Offset(100, 100);

  void updatePosition(Offset newPosition) =>
      setState(() => position = newPosition);

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                  opacity: 0.7,
                  child: widget,
                ),
                childWhenDragging: const Visibility(
                  visible: false,
                  child: Text(""),
                ),
                onDragEnd: (details) => updatePosition(details.offset),
                //TODO Implement close bar
                child: Material(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => print("Ciao"),
                        icon: const Icon(Icons.close),
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
    );
  }
}
