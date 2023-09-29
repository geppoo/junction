import 'package:flutter/cupertino.dart';
import 'package:junction/core/widget/stateful_junction_widget.dart';
import 'core/widget/junction_widget_size.dart';
import 'core/widget/stateless_junction_widget.dart';

//TODO Implementare griglia widget semi-dinamica
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO Implementare generazione dinamica dei Widget
    return   const Wrap(
      children: [
        //TODO for test purpose, remove after
        StatelessJunctionWidget(
          title: 'Test',
          height: JunctionWidgetSize.one,
          width: JunctionWidgetSize.one,
          widget: Text('dhjkasjoikdajsdjasdjadjaTestasdasdasda'),
        ),
        StatefulJunctionWidget(
            title: 'Test',
            height: JunctionWidgetSize.one,
            width: JunctionWidgetSize.one,
            widget: Text('Testasdasdsadasdasdasdadasd'),
            token: 'test',
            list: ['test']
        )

      ],
    );
  }
}
