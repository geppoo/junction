import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_size.dart';
import 'junction_widget.dart';

class StatelessJunctionWidget extends StatelessWidget implements JunctionWidget {
  const StatelessJunctionWidget(
      {super.key, required title, required height, required width, required widget});

  @override
  JunctionWidgetSize get height => height;

  @override
  String get title => title;

  @override
  Widget get widget => widget;

  @override
  JunctionWidgetSize get width => width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.size,
      height: height.size,
      child: widget,
    );
  }
}
