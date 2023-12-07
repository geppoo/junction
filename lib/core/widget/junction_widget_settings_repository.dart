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
  late final Map<String, JunctionWidgetPropertiesModel> junctionWidgetsProp;

  JunctionWidgetSettingsRepository() {
    _fileInterface = FileInterface(initialAssetFile, localFilename);
  }

  ///Initialization of all the repository properties
  init() async {
    final stringFileData = await _fileInterface?.ensureInitialized;

    _jsonFileData = await jsonDecode(stringFileData!);
    final junctionWidgets = _jsonFileData["junctionWidgets"];

    debugPrint("PROPS DATA ------> $junctionWidgets");

    //read and save all hotKeys
    Map<String, JunctionWidgetPropertiesModel> tempJunctionWidgetsProps =
        <String, JunctionWidgetPropertiesModel>{};

    for (var junction in junctionWidgets) {
      tempJunctionWidgetsProps[junction["widgetId"]] =
          JunctionWidgetPropertiesModel(
        junction["widgetId"],
        junction["offSetX"],
        junction["offSetY"],
      );
    }

    junctionWidgetsProp = tempJunctionWidgetsProps;
  }
}

class JunctionWidgetPropertiesModel {
  late final String _widgetId;

  late double _offsetX;

  late double _offsetY;

  JunctionWidgetPropertiesModel(widgetId, offsetX, offsetY)
      : _widgetId = widgetId,
        _offsetX = offsetX,
        _offsetY = offsetY;

  String get widgetId => _widgetId;

  double get offsetX => _offsetX;

  double get offsetY => _offsetY;

  set offsetX(double value) {
    if (!value.isNegative && value.isFinite) {
      _offsetX = value;
    }
  }

  set offsetY(double value) {
    if (!value.isNegative && value.isFinite) {
      _offsetY = value;
    }
  }

  set widgetId(String value) {
    if (value.isNotEmpty) {
      _widgetId = value;
    }
  }

  Map toJson() => {
        'widgetId': widgetId,
        'offSetX': offsetX,
        'offSetY': offsetY,
      };
}
