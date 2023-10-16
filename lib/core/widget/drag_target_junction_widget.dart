import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_size.dart';
import 'junction_widget.dart';

//ignore: must_be_immutable
class DragTargetJunctionWidget extends StatefulWidget
    implements JunctionWidget {
  @override
  Widget child;

  @override
  JunctionWidgetSize height = JunctionWidgetSize.one;

  @override
  JunctionWidgetSize width = JunctionWidgetSize.one;

  @override
  double bottom;

  @override
  double left;

  @override
  String title;

  DragTargetJunctionWidget(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.child,
      required this.left,
      required this.bottom});

  @override
  State<DragTargetJunctionWidget> createState() =>
      _StateDraggableJunctionWidget();
}

class _StateDraggableJunctionWidget extends State<DragTargetJunctionWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      bottom: widget.bottom,
      child: SizedBox(
          width: widget.width.size,
          height: widget.height.size,
          child: DragTarget(
            builder: (context, candidateData, rejectedData) {
              return Container(
                color: Colors.red,
                child: widget.child,
              );
            },
            onAccept: (data) {
              print("onAccept");
            },
            onLeave: (data) {
              print("onLeave");
            },
            onWillAccept: (data) {
              print("onWillAccept");
              return true;
            },
          )),
    );
  }
}
