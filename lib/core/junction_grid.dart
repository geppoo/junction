/*Stack(
      fit: StackFit.expand,
      children: [

        Positioned(
            left: 400,
            child: Draggable(
              feedback: Text("sadads"),
              child: StatelessJunctionWidget(
                title: 'Widget 1',
                height: JunctionWidgetSize.four,
                width: JunctionWidgetSize.three,
                child: Container(color: Colors.orange, child: Center(child: Text('Widget 2'))),
              ),
            )),
        Positioned(
          left: 0,
            child: Draggable(
          feedback: Text("sadads"),
          child: StatelessJunctionWidget(
            title: 'Widget 1',
            height: JunctionWidgetSize.two,
            width: JunctionWidgetSize.three,
            child: Container(
              color: Colors.teal,
              child: Center(
                child: Text('Widget 1'),
              ),
            ),
          ),
        )),

      ],
    );
* */

import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget.dart';
import 'package:junction/core/widget/draggable_junction_widget.dart';
import 'package:junction/core/widget/drag_target_junction_widget.dart';

///
/// Widget that contains the grid of the junction, it is a stack of [DragTargetJunctionWidget] and [DraggableJunctionWidget]
///
class JunctionGrid extends StatefulWidget {
  final List<Widget> junctions;
  static int padding = 10;

  //TODO check sulle collisioni durante la costruzione della griglia
  const JunctionGrid({Key? key, required this.junctions}) : super(key: key);


  /// Add a [DragTargetJunctionWidget] or [StatefulWidget] to the grid, returns [true] if the widget is added correctly
  bool addJunction(JunctionWidget junction) {
    for (Widget iter in junctions) {
      JunctionWidget i = (iter as JunctionWidget);
      if (i.left == junction.left && i.bottom == junction.bottom) {
        return false;
      }
    }
    junctions.add(junction as Widget);
    return true;
  }


  //TODO Implementare la lettura da json iniziale per disposizione e inizializzazione widget
  void readFromJson() {}

  @override
  State<JunctionGrid> createState() => _JunctionGridState();
}

class _JunctionGridState extends State<JunctionGrid> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: widget.junctions
    );
  }
}
