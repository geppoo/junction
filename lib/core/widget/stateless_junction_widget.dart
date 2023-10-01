import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_size.dart';
import 'junction_widget.dart';

//ignore: must_be_immutable
class StatelessJunctionWidget extends StatelessWidget
    implements JunctionWidget {
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
    final globalKey = GlobalKey();
    final junctionWidget = StatelessJunctionWidget(title: "widget globale", height: height, width: width, left: left, bottom: bottom, key: globalKey, child: child);

    return Positioned(
      left: left,
      bottom: bottom,
      child: SizedBox(
        width: width.size,
        height: height.size,
        child: Draggable<Key>(
          data: junctionWidget.key,
          feedback: Opacity(
            opacity: 0.5,
            child: child,
          ),
          childWhenDragging: Container(
            color: Colors.green,
            child: const Text("background when dragging"),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  double bottom;

  @override
  double left;
}
