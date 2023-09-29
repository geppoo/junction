import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_size.dart';

abstract class JunctionWidget {
  final String title;
  final JunctionWidgetSize height;
  final JunctionWidgetSize width;
  final Widget widget;

  JunctionWidget(this.title, this.height, this.width, this.widget);
}
