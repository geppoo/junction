import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:window_manager/window_manager.dart';

import 'core/main_container.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() async {
    // NON RIMUOVERE
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    final win = appWindow;
    const initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}

const borderColor = Color(0xFF805306);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WindowBorder(
          color: borderColor,
          width: 1,
          child:  const Row(
            children: [RightSide()],
          ),
        ),
      ),
    );
  }
}

