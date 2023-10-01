import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_size.dart';

import 'junction_widget.dart';

//ignore: must_be_immutable
class StatefulJunctionWidget extends StatefulWidget implements JunctionWidget {
  late final String? token;
  late final List<String>? list;

  StatefulJunctionWidget(
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
  State<StatefulJunctionWidget> createState() => _StateJunctionWidget();

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

class _StateJunctionWidget extends State<StatefulJunctionWidget> {
  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey();
    final junctionWidget = StatefulJunctionWidget(
        title: "widget globale",
        height: widget.height,
        width: widget.width,
        left: widget.left,
        bottom: widget.bottom,
        key: globalKey,
        child: widget.child);
    final isDropped = false;

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
