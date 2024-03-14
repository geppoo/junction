import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:provider/provider.dart';

import '../../config/model/junction_model.dart';
import 'junction_search_results.dart';

class JunctionSearchDelegate extends SearchDelegate {
  int selectedIndex = -1;

  JunctionSearchResults searchResults;

  JunctionSearchDelegate(this.searchResults);

  @override
  List<Widget>? buildActions(BuildContext context) {
    //TODO: fix the opening
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    return IconButton(
      onPressed: () {
        close(context, null);
        junctionModel.expandIfNot(200);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildListView(searchResults.getPathExecutable());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Map<String, String> executables = Map<String, String>.fromEntries(
        searchResults.getPathExecutable().map((e) => MapEntry(e.name, e.path)));
    return _buildListView(Fuzzy(executables.keys.toList(),
            options: FuzzyOptions(findAllMatches: true))
        .search(query)
        .map((e) => SearchResult(e.item, executables[e.item]!))
        .toList());
  }

  ListView _buildListView(List<SearchResult> executables) {
    
    return ListView.builder(
      itemCount: executables.length,
      shrinkWrap: true,
      prototypeItem: RawKeyboardListener(
        focusNode: FocusNode(),
        child: ListTile(
          title: Text(executables.map((e) => e.name).first),
        ),
      ),
      itemBuilder: (context, index) {
        final result = executables[index];
        return RawKeyboardListener(
          focusNode: FocusNode(),
          child: ListTile(
            selected: index == selectedIndex,
            title: Text(
              result.name,
            ),
            onTap: () async {
              selectedIndex = index;
              close(context, null);
              Process.run(result.path, []);
            },
          ),
        );
      },
    );
  }
}
