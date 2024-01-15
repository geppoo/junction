import 'package:flutter/cupertino.dart';
import 'package:junction/config/window/settings_window_impl.dart';
import 'package:junction/core/widget/factory/junction_widget_factory.dart';

import '../junction_widget_settings_repository.dart';

class WindowSettings implements JunctionWidget {
  final JunctionWidgetPropertiesModel _props;

  WindowSettings(JunctionWidgetPropertiesModel props) : _props = props;

  @override
  Widget build() {
    return SettingsWindowImpl(_props);
  }
}
