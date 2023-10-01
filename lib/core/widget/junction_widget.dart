import 'package:flutter/cupertino.dart';

import 'junction_widget_size.dart';

class JunctionWidget {
  late Widget child;
  late JunctionWidgetSize height;
  late String title;
  late JunctionWidgetSize width;
  late double left;
  late double bottom;

  JunctionWidget(
      {required this.child,
      required this.height,
      required this.title,
      required this.width,
      required this.left,
      required this.bottom});
}
