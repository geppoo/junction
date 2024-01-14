import 'package:flutter/material.dart';
import 'package:junction/core/widget/model/junction_widget_model.dart';
import 'package:provider/provider.dart';

import '../config/model/junction_model.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);

    return Stack(
      children: junctionModel
          .junctionWidgetSettingsRepository.junctionWidgetsProp.entries
          .map(
        (junctionWidget) {
          return JunctionWidgetModel(
            widgetProps: junctionWidget.value,
          );
        },
      ).toList(),
    );
  }
}
