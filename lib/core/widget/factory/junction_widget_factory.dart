import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_calendar.dart';

import '../../../config/junction_widget_settings_repository.dart';
import '../junction_clock.dart';

abstract class JunctionWidget {
  Widget build();
}

class JunctionWidgetFactory {
  static JunctionWidget factory(JunctionWidgetPropertiesModel props) {
    switch (props.childName) {
      case "clock":
        return JunctionClock(props);
      case "calendar":
        return JunctionCalendar(props);
    }
    throw UnimplementedError();
  }
}
