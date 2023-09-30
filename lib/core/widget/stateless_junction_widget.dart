import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_size.dart';
import 'junction_widget.dart';

class StatelessJunctionWidget extends StatelessWidget implements JunctionWidget {
  @override
  Widget child;

  @override
  JunctionWidgetSize height;

  @override
  String title;

  @override
  JunctionWidgetSize width;

  StatelessJunctionWidget(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.child,
      required this.left,
      required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      bottom: bottom,
      child: Draggable(
          feedback: SizedBox(
            child: SizedBox(
              width: width.size,
              height: height.size,
              child: child,
            ),
          ),
          child: SizedBox(
            width: width.size,
            height: height.size,
            child: child,
          )),
    );
  }

  @override
  double bottom;

  @override
  double left;
}
