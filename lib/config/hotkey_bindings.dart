import 'package:flutter/cupertino.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:junction/core/junction_model.dart';
import 'package:provider/provider.dart';

import 'model/hotkey_model.dart';

class HotKeyBindings {
  final BuildContext _context;
  Map<String, Function>? hotKeys;

  HotKeyBindings(this._context) {
    JunctionModel junctionModel = Provider.of<JunctionModel>(_context);
    hotKeys = {
      "toggleJunctionBar": () => junctionModel
          .setIsDashboardVisible(!junctionModel.getIsDashboardVisible),
    };
  }

  void init(List<HotKeyModel>? hotKeys) {
    for (HotKeyModel hotKey in hotKeys!) {
      _registerHotKey(
          HotKey(
              KeyCode.values
                  .firstWhere((e) => e.toString() == hotKey.hotKeyKey),
              modifiers: _getModifiers(hotKey.hotKeyModifiers),
              scope: HotKeyScope.system),
          hotKey.hotKeyAction);
    }
  }

  List<KeyModifier>? _getModifiers(List<String> keyModifiers) {
    List<KeyModifier>? tempModifiers;
    for (String keyModifier in keyModifiers) {
      tempModifiers!.add(
          KeyModifier.values.firstWhere((e) => e.toString() == keyModifier));
    }

    return tempModifiers;
  }

  Future<void> _registerHotKey(HotKey hotKey, String hotKeyName) async {
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        hotKeys?[hotKeyName];
      },
    );
  }
}
