import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

///Class that write and read file in junction home directory.
class FileInterface {
  ///This property contains the initialization state.
  Future? _initializer;

  ///This property is the assets file used to initialize the writable file.
  ///
  ///It usually contains all the default structure of the file.
  ///It is suggested to configure the file previously with all the basic configuration settings.
  String initialAssetFile;

  ///Name for the writable file, which will be used after the first initialization.
  String localFilename;

  FileInterface(this.initialAssetFile, this.localFilename) {
    _initializer = _readFile();
  }

  ///Getter to call before every file initialization.
  Future? get ensureInitialized => _initializer;

  ///This function initialize the default file settings for specific OS.
  ///
  /// Checks for default file configuration and create a copy of the file that is readable and writable.
  Future<File> _initializeFile() async {
    //final localDirectory = await getApplicationDocumentsDirectory();
    File file = File("tmp");
    String? home = "";
    Map<String, String> envVars = Platform.environment;
    String baseAppPath = "Junction";

    //Getting user home environment variable
    if (Platform.isMacOS) {
      home = "${envVars['HOME']}/$baseAppPath";
      file = File('$home/.config/$localFilename');
    } else if (Platform.isLinux) {
      home = "${envVars['HOME']}/$baseAppPath";
      file = File('$home/.config/$localFilename');
    } else if (Platform.isWindows) {
      home = "${envVars['UserProfile']}\\$baseAppPath";
      file = File('$home\\$localFilename');
    }

    if (!await file.exists()) {
      // read the file from assets first and create the local file with its contents
      final initialContent = await rootBundle.loadString(initialAssetFile);
      await file.create(recursive: true);
      await file.writeAsString(initialContent);
    }

    return file;
  }

  ///Private method used for file init.
  Future<String> _readFile() async {
    final file = await _initializeFile();
    var data = await file.readAsString();
    return data;
  }

  ///Method for writing String content in file.
  Future<void> writeToFile(String data) async {
    final file = await _initializeFile();
    await file.writeAsString(const JsonEncoder.withIndent('  ').convert(data));
  }

  factory FileInterface.history() =>
      FileInterface("assets/history.json", "history.json");

  factory FileInterface.executable() =>
      FileInterface("assets/executable.json", "executable.json");

  factory FileInterface.data() =>
      FileInterface("assets/data/data.json", "junction_data.json");
}
