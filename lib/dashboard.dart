import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_model.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  //TODO implementare Lettura da file JSON per generazione Widgets

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        //TODO: estrazione ed inizializzazione dei junction tramite widget prop file
        JunctionWidgetModel(
          id: "widgetTestId",
          height: 100,
          title: "2",
          width: 300,
          left: 300,
          bottom: 300,
          visible: true,
          child: Text("TEST"),
        ),
      ],
    );
  }
}
