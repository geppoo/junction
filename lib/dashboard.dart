import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  //TODO implementare Lettura da file JSON per generazione Widgets

  @override
  Widget build(BuildContext context) {
    return Stack(
      //TODO Implementare salvataggio posizione sopo spostamento del JunctionWidget
      children: [
        JunctionWidget(
          height: 100,
          title: "2",
          width: 300,
          left: 300,
          bottom: 300,
          child: const Text("Widget che si trascina"),
        ),
      ],
    );
  }
}
