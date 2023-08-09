import 'package:flutter/material.dart';
import 'package:junction/dashboard.dart';
import 'package:provider/provider.dart';

import 'expand_button.dart';
import 'junction_model.dart';



class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    return Column(children: [
      const Row(
        children: [
          Expanded(
            child: Row(children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                // child: Padding(
                //   padding: EdgeInsets.only(
                //       left: 100.0, top: 1, bottom: 1, right: 1.0),
                  child: SearchBar(
                    hintText: 'Search',
                    leading: Icon(Icons.search),
                 // ),
                ),
              ),
            ]),
          ),
          //const WindowButtons(),
          ExpandButton(),
        ],
      ),
      Row(
        children: [
          Visibility(
            visible: junctionModel.getIsDashboardVisible,
            child: const Dashboard(),
          )
        ],
      )
    ]);
  }
}
