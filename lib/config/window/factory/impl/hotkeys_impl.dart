import 'package:flutter/material.dart';
import 'package:junction/config/window/factory/settings_factory.dart';

class HotKeysSetting implements Settings {
  final dynamic _settings;

  HotKeysSetting(this._settings);

  @override
  Widget build() {
    return const Text("HotKeysSetting");
  }
}
