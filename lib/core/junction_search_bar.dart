import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:junction/core/search_builder.dart';
import 'package:provider/provider.dart';

import 'junction_model.dart';

class JunctionSearchBar extends StatelessWidget {
  final int suggestedLength;
  static double height = 50;
  const JunctionSearchBar({Key? key, required this.suggestedLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    return SearchAnchor(
      // viewConstraints: BoxConstraints(maxHeight: _height, maxWidth: _width),
      dividerColor: Colors.black87,
      builder: (BuildContext context, SearchController controller) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: SearchBar(
            controller: controller,
            onTap: () {
              junctionModel.expandIfNot(height * suggestedLength);
              EasyDebounce.debounce('deb', const Duration(milliseconds: 150),
                  () {
                controller.openView();
              });
            },
            onChanged: (_) {},
            leading: const Icon(Icons.search),
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        SearchBuilder sb = SearchBuilder(context, controller);
        return sb.generateSearch(suggestedLength);
      },
    );
  }
}
