import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';

class JunctionModel extends ChangeNotifier {
  bool _isDashboardVisible = false;
  WindowOptions customWindowOptions = const WindowOptions();

  JunctionModel(WindowOptions windowOptions){
    customWindowOptions = windowOptions;
  }

  bool get getIsDashboardVisible => _isDashboardVisible;

  //TODO Implementare personalizzazione dimensione dashboard con opzioni fisse
  void setIsDashboardVisible(bool value) {
    _isDashboardVisible = value;

    customWindowOptions = WindowOptions(
      size: getIsDashboardVisible ? const Size(800, 500) : const Size(800, 30),
    );
    windowManager.waitUntilReadyToShow(customWindowOptions, () {
      windowManager.show();
    });
    notifyListeners();
  }
}
