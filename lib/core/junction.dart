import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:junction/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:junction/core/search_bar/junction_search_bar.dart';
import '../config/hotkey_bindings.dart';
import 'expand_button.dart';
import 'junction_model.dart';

class JunctionTopBar extends StatelessWidget {
  const JunctionTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);

    //HotKey init
    hotKeyManager.unregisterAll();
    HotKeyBindings hotKeyBindings = HotKeyBindings(context);
    hotKeyBindings.init(junctionModel.junctionSettings.hotKeys);

    return Column(children: [
      ///Junction bar
      SizedBox(
        width: junctionModel.junctionSettings.junctionBarWidth,
        height: junctionModel.junctionSettings.junctionBarHeight,
        child: Row(
          children: [
            Expanded(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 1.0, top: 1, bottom: 1, right: 1.0),
                      child: JunctionSearchBar(numberOfResult: 4)),
                ),
              ]),
            ),
            //const WindowButtons(),
            const ExpandButton(),
          ],
        ),
      ),

      ///Expandable Dashboard window

      Flexible(
        flex: 1,
        child: Visibility(
          visible: junctionModel.getIsDashboardVisible,
          child: const Row(
            children: [Expanded(flex: 1, child: Dashboard())],
          ),
        ),
      )
    ]);
  }
}
