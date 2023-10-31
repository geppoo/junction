import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class JunctionModel extends ChangeNotifier {
  bool _isDashboardVisible = false;
  WindowOptions windowOptions = const WindowOptions();

  JunctionModel(this.windowOptions);

  bool get getIsDashboardVisible => _isDashboardVisible;

  void setIsDashboardVisible(bool value) {
    _isDashboardVisible = value;

    if (!getIsDashboardVisible) {
      windowOptions = const WindowOptions(
        size: Size(800, 30),
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

    windowManager.waitUntilReadyToShow(windowOptions, () {
      windowManager.setAsFrameless();
      windowManager.setResizable(false);
      if (getIsDashboardVisible) {
        windowManager.maximize();
      }
      windowManager.show();
      windowManager.focus();
    });
    notifyListeners();
  }
}
