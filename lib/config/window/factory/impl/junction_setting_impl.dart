import 'package:flutter/material.dart';
import 'package:junction/config/window/factory/settings_factory.dart';

class JunctionBarSetting implements Settings {
  final dynamic _settings;

  JunctionBarSetting(this._settings);

  @override
  Widget build() {
    return const Text("JunctionBarSetting");
  }
}
