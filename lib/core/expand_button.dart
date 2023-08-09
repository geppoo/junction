import 'package:flutter/material.dart';
import 'package:junction/core/junction_model.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({super.key});

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    return IconButton(
        iconSize: 10,
        onPressed: () {
          junctionModel
              .setIsDashboardVisible(!junctionModel.getIsDashboardVisible);
        },
        icon: junctionModel.getIsDashboardVisible
            ? const Icon(Icons.lock_open)
            : const Icon(Icons.lock));
  }
}
