import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:junction/core/junction.dart';
import 'package:junction/core/junction_model.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.transparent,
    color: const Color(0xCC222222),
    dark: false,
  );
/*  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    alwaysOnTop: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });*/

/*  doWhenWindowReady(() async {
    appWindow
      ..alignment = Alignment.topCenter
      ..show();
  });*/

  runApp(const JunctionApp());
}

class JunctionApp extends StatelessWidget {
  const JunctionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JunctionModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Junction",
        home: Scaffold(body: JunctionTopBar()),
      ),
    );
  }
}
