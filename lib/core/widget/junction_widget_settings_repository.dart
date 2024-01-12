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
  late Map<String, JunctionWidgetPropertiesModel> junctionWidgetsProp;

  JunctionWidgetSettingsRepository() {
    _fileInterface = FileInterface(initialAssetFile, localFilename);
  }

  ///Initialization of all the repository properties
  init() async {
    final stringFileData = await _fileInterface?.ensureInitialized;

    _jsonFileData = await jsonDecode(stringFileData!);
    final junctionWidgets = _jsonFileData["junctionWidgets"];

    //TODO: remove debug
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
        junction["title"],
        junction["height"],
        junction["width"],
        junction["visible"].toString().toLowerCase() == 'true',
        junction["child"],
      );
    }

    junctionWidgetsProp = tempJunctionWidgetsProps;
  }
}

///Model for JunctionWidget props initialization
class JunctionWidgetPropertiesModel {
  late final String _widgetId;
  late double _offSetX;
  late double _offSetY;
  late final String _title;
  late double _height;
  late double _width;
  late bool _visible;
  late String _childName;

  JunctionWidgetPropertiesModel(
      widgetId, offsetX, offsetY, title, height, width, visible, childName)
      : _widgetId = widgetId,
        _offSetX = offsetX,
        _offSetY = offsetY,
        _title = title,
        _height = height,
        _width = width,
        _visible = visible,
        _childName = childName;

  String get widgetId => _widgetId;

  double get offSetX => _offSetX;

  double get offSetY => _offSetY;

  String get title => _title;

  double get height => _height;

  double get width => _width;

  bool get visible => _visible;

  String get childName => _childName;

  set offSetX(double value) {
    if (!value.isNegative && value.isFinite) {
      _offSetX = value;
    } else {
      throw Exception("Invalid number (${value.runtimeType})");
    }
  }

  set offSetY(double value) {
    if (!value.isNegative && value.isFinite) {
      _offSetY = value;
    } else {
      throw Exception("Invalid number (${value.runtimeType})");
    }
  }

  set height(double value) {
    if (!value.isNegative && value.isFinite) {
      _height = value;
    } else {
      throw Exception("Invalid number (${value.runtimeType})");
    }
  }

  set width(double value) {
    if (!value.isNegative && value.isFinite) {
      _width = value;
    } else {
      throw Exception("Invalid number (${value.runtimeType})");
    }
  }

  set visible(bool value) {
    _visible = value;
  }

  set childName(String value) {
    if (value.isNotEmpty) {
      _childName = value;
    }
  }

  Map toJson() => {
        'widgetId': widgetId,
        'offSetX': offSetX,
        'offSetY': offSetY,
        'title': title,
        'height': height,
        'width': width,
        'visible': visible.toString(),
        'child': childName
      };

  static Future<void> savePropsToFile(
      Map<String, JunctionWidgetPropertiesModel> junctionWidgetsProp) async {
    List<JunctionWidgetPropertiesModel> junctionWidgets = [];

    for (var widgetProps in junctionWidgetsProp.entries) {
      junctionWidgets.add(widgetProps.value);
    }

    String fileData =
        "{ \"junctionWidgets\": ${json.encode(junctionWidgets)} }";

    //Salvo i dati riguardante il JunctionWidget modificato
    await FileInterface.data().writeToFile(fileData);
  }
}
