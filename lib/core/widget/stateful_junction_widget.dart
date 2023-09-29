import 'package:flutter/cupertino.dart';
import 'package:junction/core/widget/junction_widget.dart';
import 'package:junction/core/widget/junction_widget_size.dart';

class StatefulJunctionWidget extends StatefulWidget implements JunctionWidget {


  const StatefulJunctionWidget(
      {Key? key,
        required this.title,
        required this.height,
        required this.width,
        required this.widget, required this.token, required this.list})
      : super(key: key);



  final String  token;

  final List<String> list;

  @override
  State<StatefulWidget> createState() => _StateJunctionWidget();


  @override
  final JunctionWidgetSize height;

  @override
  final String title;

  @override
  final Widget widget;

  @override
  final JunctionWidgetSize width;

}

class _StateJunctionWidget extends State<StatefulJunctionWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width.size,
      height: widget.height.size,
      child: widget,
    );
  }
}
