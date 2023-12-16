import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:junction/core/junction.dart';
import 'package:junction/core/junction_model.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'config/junction_settings_repository.dart';
import 'core/widget/junction_widget_settings_repository.dart';

JunctionSettingsRepository? junctionSettings;
JunctionWidgetSettingsRepository? junctionData;
WindowOptions windowOptions = const WindowOptions();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await WindowManager.instance.ensureInitialized();

  //settings and data initialization
  junctionSettings = JunctionSettingsRepository();
  await junctionSettings?.init();
  //Widgets props inti
  junctionData = JunctionWidgetSettingsRepository();
  await junctionData?.init();

  windowOptions = WindowOptions(
    size: Size(junctionSettings!.junctionBarWidth,
        junctionSettings!.junctionBarHeight + 1 + 17),
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

  runApp(const JunctionApp(resizable: arg == "true"));
}

class JunctionApp extends StatelessWidget {
  final bool resizable;

  const JunctionApp({Key? key, required this.resizable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JunctionModel(windowOptions, junctionSettings!, junctionData!),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Junction",
        home: JunctionTopBar(),
      ),
    );
  }
}
