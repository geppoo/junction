import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../io/file_interface.dart';

const initialAssetFile = 'assets/data/data.json';
const localFilename = 'junction_data.json';

///Read and parse JSON configuration file.
///
/// This repository class contains all window and system related configuration.
class JunctionWidgetSettingsRepository {
  ///This property contains the initialization state.
  FileInterface? _fileInterface;

  ///This property contains the JSON decode string file content
  dynamic _jsonFileData;

  ///This property contains all the widget basic settings
  late final List<JunctionWidgetPropsModel> junctionWidgetsProp;

  JunctionWidgetSettingsRepository() {
    _fileInterface = FileInterface(initialAssetFile, localFilename);
  }

  ///Initialization of all the repository properties
  init() async {
    final stringFileData = await _fileInterface?.ensureInitialized;

    _jsonFileData = await jsonDecode(stringFileData!);
    final junctionWidgets = _jsonFileData["junctionWidgets"];

    //read and save all hotKeys
    List<JunctionWidgetPropsModel> tempJunctionWidgetsProp =
        <JunctionWidgetPropsModel>[];

    for (var junction in junctionWidgets) {
      tempJunctionWidgetsProp.add(JunctionWidgetPropsModel(
        junction["widgetKey"],
        junction["offsetX"],
        junction["offsetY"],
      ));
    }

    junctionWidgetsProp = tempJunctionWidgetsProp;
  }
}

class JunctionWidgetPropsModel {
  late final Key widgetKey;

  late final double _offsetX;

  late final double _offsetY;

  JunctionWidgetPropsModel(widgetKey, offsetX, offsetY);

  double get offsetX => _offsetX;
  double get offsetY => _offsetY;

  set offsetX(double value) {
    if (!value.isNaN && value.isFinite && !value.isNegative) {
      _offsetX = value;
    }
  }

  set offsetY(double value) {
    if (!value.isNaN && value.isFinite && !value.isNegative) {
      _offsetY = value;
    }
  }
}
