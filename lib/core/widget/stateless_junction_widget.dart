import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_size.dart';
import 'junction_widget.dart';

class StatelessJunctionWidget extends StatelessWidget implements JunctionWidget {
  const StatelessJunctionWidget(
      {Key? key,
      required this.title,
      required this.height,
      required this.width,
      required this.widget})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.size,
      height: height.size,
      child: widget,
    );
  }

  @override
  final JunctionWidgetSize height;

  @override
  final String title;

  @override
  final Widget widget;

  @override
  final JunctionWidgetSize width;


}
