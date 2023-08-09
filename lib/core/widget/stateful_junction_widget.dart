import 'package:flutter/cupertino.dart';
import 'package:junction/core/widget/junction_widget.dart';
import 'package:junction/core/widget/junction_widget_size.dart';

class StatefulJunctionWidget extends StatefulWidget implements JunctionWidget {
  const StatefulJunctionWidget(
      {super.key,
      required title,
      required height,
      required width,
      required widget});

  @override
  JunctionWidgetSize get height => height;

  @override
  String get title => title;

  @override
  Widget get widget => widget;

  @override
  JunctionWidgetSize get width => width;

  @override
  State<StatefulWidget> createState() => StateJunctionWidget();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class StateJunctionWidget extends State<StatefulJunctionWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
