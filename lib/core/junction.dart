import 'package:flutter/material.dart';
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
    return Column(children: [
      ///Junction bar
      const SizedBox(
        width: 500,
        height: 30,
        child: Row(
          children: [
            Expanded(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.0, top: 1, bottom: 1, right: 1.0),
                    child: SearchBar(
                      hintText: 'Search',
                      leading: Icon(Icons.search),
                    ),
                  ),
                ),
              ]),
            ),
            //const WindowButtons(),
            ExpandButton(),
          ],
        ),
      ),

      ///Expandable Dashboard window

      Flexible(
        flex: 1,
        child: Visibility(
          visible: junctionModel.getIsDashboardVisible,
          child: const Row(
            children: [Expanded(flex: 1,child: Dashboard())],
          ),
        ),
      )
    ]);
  }
}
