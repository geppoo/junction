import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_size.dart';

abstract class JunctionWidget {
  final String title;
  final JunctionWidgetSize height;
  final JunctionWidgetSize width;
  final Widget widget;

  const JunctionWidget(
      {required this.title,
      required this.height,
      required this.width,
      required this.widget});
}
