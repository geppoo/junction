import 'package:flutter/cupertino.dart';
import 'package:junction/config/window/factory/impl/hotkeys_impl.dart';
import 'package:junction/config/window/factory/impl/theme_impl.dart';

import 'impl/junction_setting_impl.dart';

abstract class Settings {
  Widget build();
}

class SettingsFactory {
  static Settings factory(String settingName, dynamic settings) {
    switch (settingName) {
      case "JunctionBar":
        return JunctionBarSetting(settings);
      case "HotKeys":
        return HotKeysSetting(settings);
      case "Theme":
        return ThemeSetting(settings);
    }
    throw UnimplementedError();
  }
}