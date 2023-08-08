import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:junction/core/top_bar.dart';

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
            child: const TopBar(),
          )
        ]),
      ),
    );
  }
}
