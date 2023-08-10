import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';


class JunctionModel extends ChangeNotifier {
  bool _isDashboardVisible = false;

  bool get getIsDashboardVisible => _isDashboardVisible;

  //TODO Implementare personalizzazione dimensione dashboard con opzioni fisse
  void setIsDashboardVisible(bool value) {
    _isDashboardVisible = value;
    notifyListeners();
  }
}
