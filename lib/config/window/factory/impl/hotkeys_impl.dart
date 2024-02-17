import 'package:flutter/material.dart';
import 'package:junction/config/view/hotkey_view.dart';
import 'package:junction/config/window/factory/settings_factory.dart';

class HotKeysSetting implements Settings {
  final dynamic _hotkeys;
  List<Widget> tiles = [];

  HotKeysSetting(this._hotkeys) {
    init();
  }

  init() {
    for (var e in (_hotkeys["list"] as List<dynamic>)) {
      tiles.add(HotKeyView(e));
    }
  }

  @override
  Widget build() {
    return ListView(
      children: tiles,
    );
  }
}
