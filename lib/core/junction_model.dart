import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junction/config/configuration_initializer.dart';
import 'package:window_manager/window_manager.dart';

class JunctionModel extends ChangeNotifier {
  bool _isDashboardVisible = false;
  WindowOptions _windowOptions = const WindowOptions();
  final JunctionSettingsRepository _junctionSettings;




  JunctionModel(this._windowOptions, this._junctionSettings);

  bool get getIsDashboardVisible => _isDashboardVisible;
  WindowOptions get windowOptions => _windowOptions;
  JunctionSettingsRepository get junctionSettings => _junctionSettings;


  set windowOptions(WindowOptions options){
    if(!options.isBlank!){
      _windowOptions = options;
    }
  }

  void setIsDashboardVisible(bool value) {
    _isDashboardVisible = value;

    if (!getIsDashboardVisible) {
      windowOptions = WindowOptions(
        size: Size(junctionSettings.junctionBarWidth,
            junctionSettings.junctionBarHeight),
        alwaysOnTop: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
    } else {
      windowOptions = const WindowOptions(
        alwaysOnTop: true,
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
    }

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      windowManager.setAsFrameless();

      if (getIsDashboardVisible) {
        windowManager.maximize();
      }
      windowManager.show();
      windowManager.focus();
    });
    notifyListeners();
  }

  void expandIfNot(double height){
    if(_isDashboardVisible){
      return;
    }
    windowOptions = WindowOptions(
      size:  Size(junctionSettings.junctionBarWidth, height),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () {

      windowManager.show();
    });
    notifyListeners();
  }
}
