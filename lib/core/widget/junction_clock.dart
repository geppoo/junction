import 'package:flutter/material.dart';

import '../../config/junction_widget_settings_repository.dart';
import 'factory/junction_widget_factory.dart';

class JunctionClock implements JunctionWidget {
  final JunctionWidgetPropertiesModel _props;

  JunctionClock(JunctionWidgetPropertiesModel props) : _props = props;

  @override
  Widget build() {
    return Text(_props.childName);
  }
}