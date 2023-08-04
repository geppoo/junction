import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
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
    win.title = "junction";
    await windowManager.setHasShadow(false);
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
      color: Colors.transparent,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              /// Fake window border
              Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: child!,
                  ),
                ),
              ),
              /// Window Caption
              const SizedBox(
                width: double.infinity,
                height: 56,
                child: WindowCaption(),
              ),
              /// Resizable Border
              const DragToResizeArea(
                enableResizeEdges: [
                  ResizeEdge.topLeft,
                  ResizeEdge.top,
                  ResizeEdge.topRight,
                  ResizeEdge.left,
                  ResizeEdge.right,
                  ResizeEdge.bottomLeft,
                  ResizeEdge.bottomLeft,
                  ResizeEdge.bottomRight,
                ],
                child: SizedBox(),
              ),
            ],
          ),
        );
      },
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

