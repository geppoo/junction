import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';

class JunctionModel extends ChangeNotifier {
  bool _isDashboardVisible = false;

  bool get getIsDashboardVisible => _isDashboardVisible;

  void setIsDashboardVisible(bool value) {
    _isDashboardVisible = value;
    if (_isDashboardVisible) {
      appWindow.size = const Size(500, 400);
    } else {
      appWindow.size = const Size(500, 100);
    }

    notifyListeners();
  }
}
