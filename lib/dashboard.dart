import 'package:flutter/material.dart';
import 'package:junction/core/widget/junction_widget_model.dart';
import 'package:provider/provider.dart';

import 'core/junction_model.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);

    return Stack(
      children: junctionModel
          .junctionWidgetSettingsRepository.junctionWidgetsProp.entries
          .map(
        (junctionWidget) {
          return JunctionWidgetModel(
            id: junctionWidget.value.widgetId,
            title: junctionWidget.value.title,
            height: junctionWidget.value.height,
            width: junctionWidget.value.width,
            visible: junctionWidget.value.visible,
            junctionContentWidget: Text(junctionWidget.value.title),
          );
        },
      ).toList(),
    );
  }
}
