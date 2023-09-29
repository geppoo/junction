import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_size.dart';

class StatelessJunctionWidget extends StatelessWidget {
  final JunctionWidgetSize height;
  final String title;
  final Widget child;
  final JunctionWidgetSize width;

  const StatelessJunctionWidget(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.size,
      height: height.size,
      child: child,
    );
  }
}
