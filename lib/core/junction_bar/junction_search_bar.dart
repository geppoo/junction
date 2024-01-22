import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/model/junction_model.dart';
import 'junction_search_delegate.dart';
import 'junction_search_results.dart';

class JunctionSearchBar extends StatelessWidget {
  static double height = 50;
  final int suggestedLength;
  const JunctionSearchBar({super.key, required this.suggestedLength});

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    if (suggestedLength <= 0) {
      throw ArgumentError("Length must be > 0");
    }
    return IconButton(
      onPressed: () {
        // method to show the search bar
        junctionModel.expandIfNot(1000);
        showSearch(
            context: context,
            // delegate to customize the search bar
            delegate: JunctionSearchDelegate(
                JunctionSearchResults.customPathWithExecutables(
                    ["/home/mango/Documents"])));
      },
      icon: const Icon(Icons.search),
    );
  }
}
