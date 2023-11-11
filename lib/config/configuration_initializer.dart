import 'dart:convert';

import '../core/io/file_interface.dart';

const initialAssetFile = 'assets/settings/junction.json';
const localFilename = 'junction_settings.json';

///Read and parse JSON configuration file
class JunctionSettingsRepository {
  FileInterface? _fileInterface;
  late double _junctionBarHeight;
  late double _junctionBarWidth;
  dynamic jsonFileData;

  JunctionSettingsRepository() {
    _fileInterface = FileInterface(initialAssetFile, localFilename);
  }

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

  init() async {
    final stringFileData = await _fileInterface?.ensureInitialized;

    jsonFileData = await jsonDecode(stringFileData!);
    final junctionBar = jsonFileData["junctionBar"];
    junctionBarWidth = junctionBar["junctionBarWidth"];
    junctionBarHeight = junctionBar["junctionBarHeight"];
  }
}
