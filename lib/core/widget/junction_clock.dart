import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';

import '../../config/junction_widget_settings_repository.dart';
import 'factory/junction_widget_factory.dart';

class JunctionClock implements JunctionWidget {
  final JunctionWidgetPropertiesModel _props;

  JunctionClock(JunctionWidgetPropertiesModel props) : _props = props;

  @override
  Widget build() {
    return AnalogClock(
      decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
          ),
          color: Colors.transparent,
          shape: BoxShape.circle),
      width: 150.0,
      isLive: true,
      showSecondHand: false,
      showNumbers: true,
      showAllNumbers: false,
      textScaleFactor: 1.4,
      showTicks: true,
      showDigitalClock: false,
      datetime: DateTime.now(),
    );
  }
}
