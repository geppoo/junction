import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_size.dart';

import 'junction_widget.dart';

//ignore: must_be_immutable
class DraggableJunctionWidget extends StatefulWidget implements JunctionWidget {
  late final String? token;
  late final List<String>? list;

  DraggableJunctionWidget(
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
  State<DraggableJunctionWidget> createState() =>
      _StateDraggableJunctionWidget();

  @override
  Widget child;

  @override
  JunctionWidgetSize height;

  @override
  String title;

  @override
  JunctionWidgetSize width;

  @override
  double bottom;

  @override
  double left;
}

class _StateDraggableJunctionWidget extends State<DraggableJunctionWidget> {
  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey();
    final isDropped = false;
    final junctionWidget = DraggableJunctionWidget(
        title: "widget globale",
        height: widget.height,
        width: widget.width,
        left: widget.left,
        bottom: widget.bottom,
        key: globalKey,
        child: widget.child);

    return Positioned(
      left: widget.left,
      bottom: widget.bottom,
      child: SizedBox(
        width: widget.width.size,
        height: widget.height.size,
        child: Draggable<Key>(
          data: junctionWidget.key,
          feedback: Opacity(
            opacity: 0.5,
            child: widget.child,
          ),
          childWhenDragging: Container(
            color: Colors.green,
            child: const Text("background when dragging"),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
