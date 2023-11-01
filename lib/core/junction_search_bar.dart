import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';

import 'junction_model.dart';

class JunctionSearchBar extends StatefulWidget {
  final int numberOfResult;
  late _JunctionSearchBarState state;

  JunctionSearchBar({Key? key, required this.numberOfResult}) : super(key: key){
    state = _JunctionSearchBarState(suggestedLength: numberOfResult);
  }
  double get height => state.height;

  @override
  State<StatefulWidget> createState() => state;
}

class _JunctionSearchBarState extends State<JunctionSearchBar> {
  late  List<String> _lastSearch;
  late final int _suggestedLength;
  double _height = 50;

  double get height => _height;
  final double _width = 1000;

  _JunctionSearchBarState({required int suggestedLength}) : _suggestedLength = suggestedLength {
    _lastSearch = <String>[];
    _height *= (_suggestedLength + 1) ;
  }


  @override
  Widget build(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    return SearchAnchor(
      viewConstraints: BoxConstraints(
        maxHeight: _height,
        maxWidth: _width
      ),
      dividerColor: Colors.black87,
      builder: (BuildContext context, SearchController controller) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child:
            SearchBar(
              controller: controller,
              onTap: () {
                junctionModel.expandIfNot(height) ;
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
            ),

        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<Widget>.generate(_suggestedLength, (int index) {
          final String item = _lastSearch.length > _suggestedLength ? _lastSearch[index] : "";
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
