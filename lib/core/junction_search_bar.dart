import 'package:flutter/material.dart';

class JunctionSearchBar extends StatefulWidget {
  final int numberOfResult;

  JunctionSearchBar({Key? key, required this.numberOfResult}) : super(key: key);

      @override
      State<StatefulWidget> createState() => _JunctionSearchBarState(numberOfResult);
}

class _JunctionSearchBarState extends State<JunctionSearchBar> {
  late List<String> lastSearch;
  late int suggestedLength;

  _JunctionSearchBarState({required this.suggestedLength}) {
    lastSearch = <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(suggestedLength, (int index) {
          final String item = lastSearch.length > suggestedLength ? lastSearch[index] : "";
          return ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                controller.closeView(item);
              });
            },
          );
        });
      },
    );
  }
}
