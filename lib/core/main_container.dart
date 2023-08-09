import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:junction/core/top_bar.dart';

import 'dashboard_container.dart';

const backgroundStartColor = Colors.black87;

class MainContainer extends StatelessWidget {
  const MainContainer({Key? key}) : super(key: key);
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
          ),
          const DashboardContainer(),
        ]),
      ),
    );
  }
}

