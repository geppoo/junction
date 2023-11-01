import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

const initialAssetFile = 'assets/settings/junction.json';
const localFilename = 'junction_settings.json';

///Read and parse JSON configuration file
class JunctionSettingsRepository {
  Future? _initializer;
  late double _junctionBarHeight;
  late double _junctionBarWidth;

  JunctionSettingsRepository() {
    _initializer = _readFile();
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

  Future<File> _initializeFile() async {
    final localDirectory = await getApplicationDocumentsDirectory();
    final file = File('${localDirectory.path}\\$localFilename');

    if (!await file.exists()) {
      // read the file from assets first and create the local file with its contents
      final initialContent = await rootBundle.loadString(initialAssetFile);
      await file.create();
      await file.writeAsString(initialContent);
    }

    return file;
  }

  Future _readFile() async {
    final file = await _initializeFile();
    var data = await file.readAsString();
    var jsonData = json.decode(data);

    final junctionBar = jsonData["junctionBar"];
    junctionBarHeight = junctionBar["junctionBarHeight"];
    junctionBarWidth = junctionBar["junctionBarWidth"];
  }

  Future<void> writeToFile(String data) async {
    final file = await _initializeFile();
    await file.writeAsString(data);
  }
}
