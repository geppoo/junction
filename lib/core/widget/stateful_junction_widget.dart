import 'package:flutter/cupertino.dart';
import 'package:junction/core/widget/junction_widget_size.dart';

class StatefulJunctionWidget extends StatefulWidget {
  final String? token;
  final List<String>? list;
  final JunctionWidgetSize height;
  final String title;
  final Widget child;
  final JunctionWidgetSize width;

  const StatefulJunctionWidget(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.child,
      this.token,
      this.list});

  @override
  State<StatefulJunctionWidget> createState() => _StateJunctionWidget();
}

class _StateJunctionWidget extends State<StatefulJunctionWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width.size,
      height: widget.height.size,
      child: widget.child,
    );
  }
}
