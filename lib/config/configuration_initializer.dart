import 'dart:convert';

import '../core/io/file_interface.dart';
import 'model/hotkey_model.dart';

const initialAssetFile = 'assets/settings/junction.json';
const localFilename = 'junction_settings.json';

///Read and parse JSON configuration file
class JunctionSettingsRepository {
  FileInterface? _fileInterface;
  dynamic jsonFileData;
  late double _junctionBarHeight;
  late double _junctionBarWidth;
  List<HotKeyModel>? _hotKeys;

  JunctionSettingsRepository() {
    _fileInterface = FileInterface(initialAssetFile, localFilename);
  }

  double get junctionBarHeight => _junctionBarHeight;
  double get junctionBarWidth => _junctionBarWidth;
  List<HotKeyModel>? get hotKeys => _hotKeys;

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

  init() async {
    final stringFileData = await _fileInterface?.ensureInitialized;

    jsonFileData = await jsonDecode(stringFileData!);
    final junctionBar = jsonFileData["junctionBar"];
    junctionBarWidth = junctionBar["junctionBarWidth"];
    junctionBarHeight = junctionBar["junctionBarHeight"];

    //read and save all hotKeys
    for (var hotKey in jsonFileData["HotKeys"]) {
      _hotKeys?.add(HotKeyModel(hotKey["name"], hotKey["modifiers"],
          hotKey["key"], hotKey["action"]));
    }
  }
}
