import 'package:flutter/material.dart';

//ignore: must_be_immutable
class JunctionWidget extends StatefulWidget {
  late final String? token;
  late final List<String>? list;

  Widget child;

  double height;

  String title;

  double width;

  double bottom;

  double left;

  JunctionWidget(
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
  State<JunctionWidget> createState() => _StateJunctionWidget();
}

class _StateJunctionWidget extends State<JunctionWidget> {
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
