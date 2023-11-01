import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class JunctionSearchBar extends StatefulWidget {
  final int numberOfResult;

  const JunctionSearchBar({Key? key, required this.numberOfResult}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _JunctionSearchBarState(suggestedLength: numberOfResult);
}

class _JunctionSearchBarState extends State<JunctionSearchBar> {
  late List<String> lastSearch;
  late int suggestedLength;
  double height = 50;
  double width = 1000;

  _JunctionSearchBarState({required this.suggestedLength}) {
    lastSearch = <String>[];
    height *= suggestedLength;
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      viewConstraints: BoxConstraints(
        maxHeight: height,
        maxWidth: width
      ),
      dividerColor: Colors.black87,
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
        return List<Widget>.generate(suggestedLength, (int index) {
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
