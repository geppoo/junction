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

  void updatePosition(Offset newPosition) => setState(() => position = newPosition);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Draggable<Key>(
          maxSimultaneousDrags: 1,
          feedback: Opacity(
            opacity: 0.5,
            child: widget.child,
          ),
          childWhenDragging: Container(
            color: Colors.green,
            child: const Text("background when dragging"),
          ),
          onDragEnd: (details) => updatePosition(details.offset),
          child: widget.child,
        ),
      ),
    );
  }
}
