import 'package:flutter/material.dart';
import 'package:junction/core/junction_model.dart';
import 'package:junction/core/widget/junction_widget_size.dart';
import 'package:provider/provider.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({super.key});

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    return IconButton(
        iconSize: 30,
        onPressed: () {
          junctionModel
              .setIsDashboardVisible(!junctionModel.getIsDashboardVisible);
        },
        icon: junctionModel.getIsDashboardVisible
            ? const Icon(Icons.arrow_drop_up)
            : const Icon(Icons.arrow_drop_down));
  }
}
