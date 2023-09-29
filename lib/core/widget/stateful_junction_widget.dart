import 'package:flutter/cupertino.dart';
import 'package:junction/core/widget/junction_widget.dart';
import 'package:junction/core/widget/junction_widget_size.dart';

class StatefulJunctionWidget extends StatefulWidget implements JunctionWidget {
  const StatefulJunctionWidget(
      {super.key,
      required title,
      required height,
      required width,
      required widget,
      required this.token,
      required this.list});

  @override
  JunctionWidgetSize get height => height;

  @override
  String get title => title;

  @override
  Widget get widget => widget;

  @override
  JunctionWidgetSize get width => width;

  final String  token;

  final List<String> list;

  @override
  State<StatefulWidget> createState() => StateJunctionWidget(token, list);
}

class StateJunctionWidget extends State<StatefulJunctionWidget> {
  final String _token ;
  final List<String> _list;

  StateJunctionWidget(this._token, this._list);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width.size,
      height: widget.height.size,
      child: widget,
    );
  }
}
