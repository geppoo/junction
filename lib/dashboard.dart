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
    return JunctionGrid();
  }
}
