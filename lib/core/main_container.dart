import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';


const backgroundStartColor = Colors.black87;

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: backgroundStartColor,
        ),
        child: Column(children: [
          WindowTitleBarBox(
            child: Row(
              //TODO Implementare TopNavBar inserendo come argomento child: Row() in MoveWindow()
              children: [
                Expanded(
                    child: MoveWindow(
                        child: const Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: EdgeInsets.only(left: 100.0,top: 10,right: 10.0),
                        child: SearchBar(
                          hintText: 'Search',
                        ),
                      ),
                    ),
                  ],
                ))),
                const WindowButtons()
              ],
            ),
          )
        ]),
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFF805306),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: backgroundStartColor,
    iconMouseDown: backgroundStartColor);

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  WindowButtonsState createState() => WindowButtonsState();
}

class WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              )
            : MaximizeWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              ),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
