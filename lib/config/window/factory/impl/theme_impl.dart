import 'package:flutter/material.dart';
import 'package:junction/config/window/factory/settings_factory.dart';

class ThemeSetting implements Settings {
  final dynamic _settings;

  ThemeSetting(this._settings);

  @override
  Widget build() {
    return const Text("ThemeSetting");
  }
}
