import 'dart:io';

import 'package:flutter/services.dart';

class FileInterface {
  Future? _initializer;
  String initialAssetFile;
  String localFilename;

  FileInterface(this.initialAssetFile, this.localFilename) {
    _initializer = _readFile();
  }

  Future? get ensureInitialized => _initializer;

  Future<File> _initializeFile() async {
    //final localDirectory = await getApplicationDocumentsDirectory();
    File file = File("tmp");
    String? home = "";
    Map<String, String> envVars = Platform.environment;

    //Getting user home environment variable
    if (Platform.isMacOS) {
      home = envVars['HOME'];
      file = File('$home/.config/junction/$localFilename');
    } else if (Platform.isLinux) {
      home = envVars['HOME'];
      file = File('$home/.config/junction/$localFilename');
    } else if (Platform.isWindows) {
      home = envVars['UserProfile'];
      file = File('$home\\$localFilename');
    }

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
