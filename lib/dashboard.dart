import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junction/core/widget/stateful_junction_widget.dart';
import 'core/junction_grid.dart';
import 'core/widget/junction_widget_size.dart';
import 'core/widget/stateless_junction_widget.dart';

//TODO Implementare griglia widget semi-dinamica
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  //TODO implementare Lettura da file JSON

  @override
  Widget build(BuildContext context) {
    //TODO Implementare generazione dinamica dei Widget
    return JunctionGrid(
      junctions: [
        StatelessJunctionWidget(
          height: JunctionWidgetSize.one,
          title: "1",
          width: JunctionWidgetSize.one,
          left: 100,
          bottom: 100,
          child: Draggable(
            feedback: Container(
              color: Colors.blue,
              child: const Text("drag"),
            ),
            childWhenDragging: Container(
              color: Colors.green,
              child: const Text("drag"),
            ),
            child: Container(
              color: Colors.red,
              child: const Text("drag"),
            ),
          ),
        ),
        StatefulJunctionWidget(
          height: JunctionWidgetSize.one,
          title: "2",
          width: JunctionWidgetSize.one,
          left: 600,
          bottom: 600,
          child: DragTarget(
            builder: (context, candidateData, rejectedData) {
              return Container(
                color: Colors.red,
                child: const Text("drag"),
              );
            },
            onAccept: (data) {
              print("accept");
            },
            onLeave: (data) {
              print("leave");
            },
            onWillAccept: (data) {
              print("will accept");
              return true;
            },
          ),
        ),
      ],
    );
  }
}
