import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:junction/core/junction.dart';
import 'package:junction/core/junction_model.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:async';

import 'config/configuration_initializer.dart';
import 'config/hotkey_bindings.dart';

JunctionSettingsRepository? junctionSettings;
WindowOptions windowOptions = const WindowOptions();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await WindowManager.instance.ensureInitialized();

  //settings initialization
  junctionSettings = JunctionSettingsRepository();
  await junctionSettings?.init();

  windowOptions = WindowOptions(
    size: Size(junctionSettings!.junctionBarWidth,
        junctionSettings!.junctionBarHeight),
    alwaysOnTop: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  const arg = String.fromEnvironment("resizable");

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setResizable(arg == "true");
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

  runApp(const JunctionApp(resizable: arg == "true"));
}

class JunctionApp extends StatelessWidget {
  final bool resizable;

  const JunctionApp({Key? key, required this.resizable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotKeyBindings hotKeyBindings = HotKeyBindings(context);
    hotKeyBindings.init(junctionSettings!.hotKeys);

    return ChangeNotifierProvider(
      create: (context) => JunctionModel(windowOptions, junctionSettings!),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Junction",
        home: JunctionTopBar(),
      ),
    );
  }
}
