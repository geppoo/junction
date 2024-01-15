import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:junction/config/theme/custom_theme.dart';
import 'package:junction/config/theme/custom_theme_settings_model.dart';
import 'package:junction/config/theme/theme_variant.dart';

import '../core/io/file_interface.dart';
import 'model/hotkey_model.dart';

const initialAssetFile = 'assets/settings/junction.json';
const localFilename = 'junction_settings.json';

///Read and parse JSON configuration file.
///
/// This repository class contains all window and system related configuration.
class JunctionSettingsRepository {
  ///This property contains the initialization state.
  FileInterface? _fileInterface;

  ///This property contains the JSON decode string file content
  dynamic _jsonFileData;

  ///Property for Junction top bar height
  late double _junctionBarHeight;

  ///Property for Junction top bar width
  late double _junctionBarWidth;

  ///Property for the list of all the app hotkeys
  List<HotKeyModel> _hotKeys = <HotKeyModel>[];

  ///Property for the theme settings
  late ThemeData customTheme;

  JunctionSettingsRepository() {
    _fileInterface = FileInterface(initialAssetFile, localFilename);
  }

  dynamic get jsonData => _jsonFileData;
  double get junctionBarHeight => _junctionBarHeight;
  double get junctionBarWidth => _junctionBarWidth;
  List<HotKeyModel> get hotKeys => _hotKeys;

  set hotKeys(List<HotKeyModel> value) {
    if (value.isNotEmpty) {
      _hotKeys = value;
    }
  }

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

  ///Initialization of all the settings properties
  init() async {
    final stringFileData = await _fileInterface?.ensureInitialized;

    _jsonFileData = await jsonDecode(stringFileData!);

    //bar settings
    final junctionBar = _jsonFileData["JunctionBar"];
    junctionBarWidth = junctionBar["junctionBarWidth"];
    junctionBarHeight = junctionBar["junctionBarHeight"];

    //hotKeys settings
    List<HotKeyModel> tempHotKeys = <HotKeyModel>[];

    for (var hotKey in _jsonFileData["HotKeys"]) {
      tempHotKeys.add(HotKeyModel(
        hotKey["name"],
        _getStringModifiers(hotKey["modifiers"]),
        hotKey["key"],
        hotKey["action"],
      ));
    }

    hotKeys = tempHotKeys;

    //theme settings
    late List<ThemeVariant> variantList = [];
    late List<CustomTheme> customThemes = [];
    final themeSettings = _jsonFileData["Theme"];

    for (var theme in themeSettings["themes"]) {
      for (var variant in theme["variants"]) {
        variantList.add(ThemeVariant(
          variant["variantId"],
          Color(int.parse(variant["primary"])),
          Color(int.parse(variant["onPrimary"])),
          Color(int.parse(variant["secondary"])),
          Color(int.parse(variant["onSecondary"])),
        ));
      }
      customThemes.add(CustomTheme(
        theme["id"],
        variantList,
      ));
    }

    CustomThemeSettingsModel customThemeSettingsModel =
        CustomThemeSettingsModel(
      themeSettings["activeThemeId"],
      themeSettings["activeVariantId"],
      customThemes,
    );

    ThemeVariant? activeThemeVariant =
        customThemeSettingsModel.getActiveThemeVariant();

    customTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: activeThemeVariant!.primary,
        brightness: Brightness.light,
        primary: activeThemeVariant.primary,
        onPrimary: activeThemeVariant.onPrimary,
        secondary: activeThemeVariant.secondary,
        onSecondary: activeThemeVariant.onSecondary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: activeThemeVariant.secondary,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: activeThemeVariant.secondary,
      ),
      dividerColor: activeThemeVariant.secondary,
      useMaterial3: true,
    );
  }

  ///Extract all the modifiers for the given hotKey setting
  List<String> _getStringModifiers(List<dynamic> hotKeyModifiers) {
    List<String> tempHotKeyModifiers = <String>[];
    for (var hotKeyModifier in hotKeyModifiers) {
      tempHotKeyModifiers.add(hotKeyModifier);
    }

    return tempHotKeyModifiers;
  }
}
