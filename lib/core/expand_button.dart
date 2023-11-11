import 'package:flutter/material.dart';
import 'package:junction/core/junction_model.dart';
import 'package:provider/provider.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({super.key});

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    return FloatingActionButton(
      onPressed: () {
        junctionModel
            .setIsDashboardVisible = !junctionModel.getIsDashboardVisible;
      },
      child: junctionModel.getIsDashboardVisible
          ? const Icon(Icons.arrow_drop_up)
          : const Icon(Icons.arrow_drop_down),
    );
  }
}
