import 'package:flutter/cupertino.dart';
import 'core/widget/stateless_junction_widget.dart';

//TODO Implementare griglia widget semi-dinamica
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO Implementare generazione dinamica dei Widget
    return const Wrap(
      children: [
        StatelessJunctionWidget(
          title: null,
          height: null,
          width: null,
          widget: null,
        )
      ],
    );
  }
}
