import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junction/config/junction_settings_repository.dart';
import 'package:window_manager/window_manager.dart';

///Model used for the global application.
///
/// This class is used for the application global Provider that manages the app state.
class JunctionModel extends ChangeNotifier {
  bool _isDashboardVisible = false;
  WindowOptions _windowOptions = const WindowOptions();
  final JunctionSettingsRepository _junctionSettings;

  JunctionModel(this._windowOptions, this._junctionSettings);

  ///Return if the dashboard is open
  bool get isDashboardVisible => _isDashboardVisible;
  WindowOptions get windowOptions => _windowOptions;
  JunctionSettingsRepository get junctionSettings => _junctionSettings;

  set windowOptions(WindowOptions options) {
    if (!options.isBlank!) {
      _windowOptions = options;
    }
  }

  ///Method that change the overlay visibility status
  ///
  /// The [value] need to be the negation of the property [isDashboardVisible]
  void setIsDashboardVisible(bool value) {
    _isDashboardVisible = value;

    if (!isDashboardVisible) {
      windowOptions = WindowOptions(
        size: Size(junctionSettings.junctionBarWidth,
            junctionSettings.junctionBarHeight + 1 + 17),
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

      if (isDashboardVisible) {
        windowManager.maximize();
      }
      windowManager.show();
      windowManager.focus();
    });
    notifyListeners();
  }

  ///Method that expand the window to fit the suggestion bar result if the dashboard is not visible.
  void expandIfNot(double height) {
    if (_isDashboardVisible) {
      return;
    }
    windowOptions = WindowOptions(
      size: Size(junctionSettings.junctionBarWidth, height),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () {
      windowManager.show();
    });
    notifyListeners();
  }

  void setWindowSize(Size windowSize) {
    windowOptions = WindowOptions(
      size: windowSize,
      alwaysOnTop: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      windowManager.setAsFrameless();
      windowManager.show();
      windowManager.focus();
    });
    notifyListeners();
  }
}
