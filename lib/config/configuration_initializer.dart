import 'dart:convert';

import 'package:flutter/services.dart';

///Read and parse JSON configuration file
class JunctionSettings {
  Future? _initializer;
  late double _junctionBarHeight;
  late double _junctionBarWidth;

  JunctionSettings() {
    _initializer = _init();
  }

  Future _init() async {
    final String response =
        await rootBundle.loadString('assets/settings/junction.json');
    final data = await json.decode(response);

    final junctionBar = data["junctionBar"];
    junctionBarHeight = junctionBar["junctionBarHeight"];
    junctionBarWidth = junctionBar["junctionBarWidth"];
  }

  Future? get ensureInitialized => _initializer;

  double get junctionBarHeight => _junctionBarHeight;
  double get junctionBarWidth => _junctionBarWidth;

  set junctionBarHeight(double value) {
    if (value >= 30) {
      _junctionBarHeight = value;
    }
  }

  set junctionBarWidth(double value) {
    if (value >= 300) {
      _junctionBarWidth = value;
    }
  }
}
