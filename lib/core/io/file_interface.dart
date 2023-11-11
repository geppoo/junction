import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileInterface {
  Future? _initializer;
  String initialAssetFile;
  String localFilename;

  FileInterface(this.initialAssetFile, this.localFilename){
    _initializer = _readFile();
  }

  Future? get ensureInitialized => _initializer;

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

  Future<String> _readFile() async {
    final file = await _initializeFile();
    var data = await file.readAsString();
    return data;
  }

  Future<void> writeToFile(String data) async {
    final file = await _initializeFile();
    await file.writeAsString(data);
  }
}
