import 'package:flutter/material.dart';
import 'package:junction/config/view/theme_view.dart';
import 'package:junction/config/window/factory/settings_factory.dart';

class ThemeSetting implements Settings {
  final dynamic _themes;
  List<Widget> tiles = [];

  ThemeSetting(this._themes);

  @override
  Widget build() {
    return ThemeView(_themes);
  }
}
