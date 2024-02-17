import 'package:flutter/material.dart';
import 'package:junction/config/window/factory/settings_factory.dart';

import '../../../view/number_view.dart';

class JunctionBarSetting implements Settings {
  final dynamic _settings;

  JunctionBarSetting(this._settings);

  @override
  Widget build() {
    return ListView(
      children: [
        NumberView("Bar Height", _settings["junctionBarHeight"]),
        NumberView("Bar Width", _settings["junctionBarWidth"]),
      ],
    );
  }
}
