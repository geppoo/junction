import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:junction/core/junction.dart';
import 'package:junction/core/junction_model.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() async {
    // NON RIMUOVERE
    windowManager.setResizable(true);
    windowManager.setAsFrameless();
    final win = appWindow;
    const initialSize = Size(500, 100);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.topCenter;
    win.title = "Junction";
    win.show();
  });
}

const borderColor = Color(0xFF805306);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JunctionModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: TopBar()),
      ),
    );
  }
}
