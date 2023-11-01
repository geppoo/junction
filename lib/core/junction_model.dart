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
  set setIsDashboardVisible(bool value) {
    _isDashboardVisible = value;

    customWindowOptions = WindowOptions(
      size: getIsDashboardVisible ? const Size(800, 500) : const Size(800, 50),
    );
    windowManager.waitUntilReadyToShow(customWindowOptions, () {
      windowManager.show();
    });
    notifyListeners();

  }

  void expandIfNot(double height){
    if(_isDashboardVisible){
      return;
    }
    customWindowOptions = WindowOptions(
      size:  Size(800, height),
    );
    windowManager.waitUntilReadyToShow(customWindowOptions, () {
      windowManager.show();
    });
    notifyListeners();
  }
}
