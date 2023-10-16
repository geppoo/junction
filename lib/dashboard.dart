import 'package:flutter/material.dart';
import 'package:junction/core/widget/draggable_junction_widget.dart';
import 'core/junction_grid.dart';
import 'core/widget/junction_widget_size.dart';
import 'core/widget/drag_target_junction_widget.dart';

//TODO Implementare griglia widget semi-dinamica
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  //TODO implementare Lettura da file JSON

  @override
  Widget build(BuildContext context) {
    //TODO Implementare generazione dinamica dei Widget
    return JunctionGrid(

      //TODO Implementare spostamento widget Draggable su DragTarget
      junctions: [
        DragTargetJunctionWidget(
            height: JunctionWidgetSize.one,
            title: "1",
            width: JunctionWidgetSize.one,
            left: 100,
            bottom: 100,
            child: const Text("Widget stronzo")),
        DraggableJunctionWidget(
          height: JunctionWidgetSize.one,
          title: "2",
          width: JunctionWidgetSize.one,
          left: 300,
          bottom: 300,
          child: const Text("Widget che si trascina"),
        ),
      ],
    );
  }
}
