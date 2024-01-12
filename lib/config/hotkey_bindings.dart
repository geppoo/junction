import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:junction/config/model/junction_model.dart';
import 'package:provider/provider.dart';

import 'model/hotkey_model.dart';

///Class that initialize all the app HotKeys shortcuts
class HotKeyBindings {
  final BuildContext _context;

  ///Map of all the possible shortcut functions
  Map<String, Function> hotKeys = <String, Function>{};

  HotKeyBindings(this._context) {
    JunctionModel junctionModel = Provider.of<JunctionModel>(_context);
    hotKeys = {
      "toggleJunctionBar": () => junctionModel
          .setIsDashboardVisible(!junctionModel.isDashboardVisible),
    };
  }

  ///Method to initialize all the hotKeys passing the hotKeys list
  void init(List<HotKeyModel> hotKeys) async {
    for (HotKeyModel hotKey in hotKeys) {
      _registerHotKey(
          HotKey(
              KeyCode.values.firstWhere((e) => e.keyLabel == hotKey.hotKeyKey,
                  orElse: () => KeyCode.alt),
              modifiers: _getModifiers(hotKey.hotKeyModifiers),
              scope: HotKeyScope.system),
          hotKey.hotKeyAction);
    }
  }

  ///Returns al the hotKey modifiers given a list of all the String modifiers
  List<KeyModifier>? _getModifiers(List<String> keyModifiers) {
    List<KeyModifier>? tempModifiers = <KeyModifier>[];
    for (String keyModifier in keyModifiers) {
      tempModifiers
          .add(KeyModifier.values.firstWhere((e) => e.keyLabel == keyModifier));
    }

    return tempModifiers;
  }

  ///This method, given an [hotKey] and the [hotKeyName], register the shortcut in the application with the associated Function.
  Future<void> _registerHotKey(HotKey hotKey, String hotKeyName) async {
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        hotKeys[hotKeyName]?.call();
      },
    );
  }
}
