import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

///Custom configuration class for major UI preferences
///
/// This class container all the UI settings for the Junction app.
/// The preferences are stored/read in a JSON file -> settings.json
/// NOTE: might check shared_preferences lib for enhancement
class JunctionConfiguration {
  File settingsFile = File("assets/settings.json");

  Future<void> readSettingsFile() async {
    final String response = await rootBundle.loadString('assets/settings.json');
    final data = await json.decode(response);
    return data;
  }
}
