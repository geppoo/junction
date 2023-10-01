import 'package:flutter/cupertino.dart';
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
    return Positioned(
      left: widget.left,
      bottom: widget.bottom,
      child: Draggable(
          feedback: SizedBox(
            child: SizedBox(
              width: widget.width.size,
              height: widget.height.size,
              child: widget.child,
            ),
          ),
          child: SizedBox(
            width: widget.width.size,
            height: widget.height.size,
            child: widget.child,
          )),
    );
  }
}
