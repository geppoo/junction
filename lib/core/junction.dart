import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:junction/core/junction_search_bar.dart';
import 'package:junction/dashboard.dart';
import 'package:provider/provider.dart';

import 'expand_button.dart';
import 'junction_model.dart';

///Variable that specify the height of the Junction bar
double junctionHeight = 50;

class JunctionTopBar extends StatelessWidget {
  const JunctionTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);

    //TODO Implementare configurazione dinamica delle shortcut
    final HotKey hotKeyOpenJunction = HotKey(
      KeyCode.keyJ,
      modifiers: [KeyModifier.alt],
      scope: HotKeyScope.system,
    );

    _registerExpandJunctionHotkey(hotKeyOpenJunction, junctionModel);

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

  Future<void> _registerExpandJunctionHotkey(HotKey hotKey, JunctionModel junctionModel) async {
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        junctionModel.setIsDashboardVisible(!junctionModel.getIsDashboardVisible);
      },
    );
  }
}
