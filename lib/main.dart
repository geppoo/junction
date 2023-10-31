import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:junction/core/junction.dart';
import 'package:junction/core/junction_model.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:async';

WindowOptions windowOptions = const WindowOptions(
  size: Size(800, 30),
  alwaysOnTop: true,
  backgroundColor: Colors.transparent,
  skipTaskbar: false,
  titleBarStyle: TitleBarStyle.hidden,
  windowButtonVisibility: false,
);

//TODO Implementare la generalizzazione delle impostazioni della barra
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await WindowManager.instance.ensureInitialized();

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setResizable(false);
    await windowManager.show();
    await windowManager.focus();
    doWhenWindowReady(() async {
      appWindow
        ..alignment = Alignment.topCenter
        ..show();
    });
    await Window.setEffect(
      effect: WindowEffect.transparent,
      color: Colors.transparent,
    );
  });

  // Must add this line.
  WidgetsFlutterBinding.ensureInitialized();
  // For hot reload, `unregisterAll()` needs to be called.
  await hotKeyManager.unregisterAll();

  runApp(const JunctionApp());
}

class JunctionApp extends StatelessWidget {
  const JunctionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JunctionModel(windowOptions),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Junction",
        home: JunctionTopBar(),
      ),
    );
  }
}
