import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junction/core/widget/junction_widget.dart';
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
      junctions: [
        /*TODO: Fare refactor generico erp le classi [StatelessJunctionWidget] e [StatefulJunctionWidget] che devono diventare Draggable e DragTarget entrambi con lo stato.
          Aggiungere nel DragTarget la proprietá is dropped per quando viene rilasciato un widget sopra di lui. Da lí ci calcoliamo la collisione.
         */
        DragTargetJunctionWidget(
            height: JunctionWidgetSize.one,
            title: "1",
            width: JunctionWidgetSize.one,
            left: 100,
            bottom: 100,
            child: Text("Widget stronzo")),
        DraggableJunctionWidget(
          height: JunctionWidgetSize.one,
          title: "2",
          width: JunctionWidgetSize.one,
          left: 300,
          bottom: 300,
          child: Text("Widget che si trascina"),
        ),
      ],
    );
  }
}
