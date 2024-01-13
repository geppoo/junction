import 'package:flutter/material.dart';
import 'package:junction/config/model/junction_model.dart';
import 'package:provider/provider.dart';

///Widget for the overlay toggle button
class ExpandButton extends StatelessWidget {
  const ExpandButton({super.key});

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    return FloatingActionButton.small(
      backgroundColor:
          Theme.of(context).floatingActionButtonTheme.backgroundColor,
      onPressed: () {
        junctionModel.setIsDashboardVisible(!junctionModel.isDashboardVisible);
      },
      child: junctionModel.isDashboardVisible
          ? const Icon(Icons.arrow_drop_up)
          : const Icon(Icons.arrow_drop_down),
    );
  }
}
