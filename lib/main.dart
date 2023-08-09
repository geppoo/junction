import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:junction/core/top_bar.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() async {
    // NON RIMUOVERE

    windowManager.setAsFrameless();
    final win = appWindow;
    const initialSize = Size(500, 20);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.topCenter;
    win.title = "Custom window with Flutter";
    win.show();
  });
}

const borderColor = Color(0xFF805306);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: TopBar()),
    );
  }
}
