import 'dart:convert';

import '../core/io/file_interface.dart';
import 'model/hotkey_model.dart';

const initialAssetFile = 'assets/settings/junction.json';
const localFilename = 'junction_settings.json';

///Read and parse JSON configuration file.
///
/// This repository class contains all window and system related configuration.
class JunctionSettingsRepository {
  ///This property contains the initialization state.
  FileInterface? _fileInterface;

  ///This property contains the JSON decode string file content
  dynamic _jsonFileData;

  ///Property for Junction top bar height
  late double _junctionBarHeight;

  ///Property for Junction top bar width
  late double _junctionBarWidth;

  ///Property for the list of all the app hotkeys
  List<HotKeyModel> _hotKeys = <HotKeyModel>[];

  JunctionSettingsRepository() {
    _fileInterface = FileInterface(initialAssetFile, localFilename);
  }

  double get junctionBarHeight => _junctionBarHeight;
  double get junctionBarWidth => _junctionBarWidth;
  List<HotKeyModel> get hotKeys => _hotKeys;

  set hotKeys(List<HotKeyModel> value) {
    if (value.isNotEmpty) {
      _hotKeys = value;
    }
  }

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

  ///Initialization of all the repository properties
  init() async {
    final stringFileData = await _fileInterface?.ensureInitialized;

    _jsonFileData = await jsonDecode(stringFileData!);
    final junctionBar = _jsonFileData["junctionBar"];
    junctionBarWidth = junctionBar["junctionBarWidth"];
    junctionBarHeight = junctionBar["junctionBarHeight"];

    //read and save all hotKeys
    List<HotKeyModel> tempHotKeys = <HotKeyModel>[];

    for (var hotKey in _jsonFileData["HotKeys"]) {
      tempHotKeys.add(HotKeyModel(
        hotKey["name"],
        _getStringModifiers(hotKey["modifiers"]),
        hotKey["key"],
        hotKey["action"],
      ));
    }

    hotKeys = tempHotKeys;
  }

  ///Extract all the modifiers for the given hotKey setting
  List<String> _getStringModifiers(List<dynamic> hotKeyModifiers) {
    List<String> tempHotKeyModifiers = <String>[];
    for (var hotKeyModifier in hotKeyModifiers) {
      tempHotKeyModifiers.add(hotKeyModifier);
    }

    return tempHotKeyModifiers;
  }
}
