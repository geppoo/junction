import 'package:flutter/cupertino.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:junction/core/junction_model.dart';
import 'package:provider/provider.dart';

import 'model/hotkey_model.dart';

class HotKeyBindings {
  final BuildContext _context;
  Map<String, Function> hotKeys = <String, Function>{};

  HotKeyBindings(this._context) {
    JunctionModel junctionModel = Provider.of<JunctionModel>(_context);
    hotKeys = {
      "toggleJunctionBar": () => junctionModel
          .setIsDashboardVisible(!junctionModel.getIsDashboardVisible),
    };
  }

  Future<void> init(List<HotKeyModel> hotKeys) async {
    for (HotKeyModel hotKey in hotKeys) {
      await _registerHotKey(
          HotKey(
              KeyCode.values
                  .firstWhere((e) => e.keyLabel == hotKey.hotKeyKey, orElse: () => KeyCode.alt),
              modifiers: _getModifiers(hotKey.hotKeyModifiers),
              scope: HotKeyScope.system),
          hotKey.hotKeyAction);
    }
  }

  List<KeyModifier>? _getModifiers(List<String> keyModifiers) {
    List<KeyModifier>? tempModifiers = <KeyModifier>[];
    for (String keyModifier in keyModifiers) {
      tempModifiers.add(
          KeyModifier.values.firstWhere((e) => e.keyLabel == keyModifier));
    }

    return tempModifiers;
  }

  Future<void> _registerHotKey(HotKey hotKey, String hotKeyName) async {
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        () => hotKeys[hotKeyName];
      },
    );
  }
}
