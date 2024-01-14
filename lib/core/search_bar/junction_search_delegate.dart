import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:junction/config/junction_settings_repository.dart';
import 'package:junction/core/search_bar/junction_search_results.dart';
import 'package:provider/provider.dart';

class JunctionSearchDelegate extends SearchDelegate {
  int selectedIndex = -1;

  JunctionSearchResults searchResults;

  JunctionSearchDelegate(this.searchResults);

  @override
  List<Widget>? buildActions(BuildContext context) {
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
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildListView(
        searchResults.getPathExecutable()
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Map<String, String> executables = Map<String, String>.fromEntries(
        searchResults.getPathExecutable().map((e) => MapEntry(e.name, e.path)));
    return _buildListView(Fuzzy(executables.keys.toList())
        .search(query)
        .map((e) => SearchResult(e.item , executables[e.item] as String))
        .toList());
  }

  ListView _buildListView(List<SearchResult> executables) {
    return ListView.builder(
      itemCount: executables.length,
      clipBehavior: Clip.antiAlias,
      itemBuilder: (context, index) {
        final result = executables[index];
        return RawKeyboardListener(
          focusNode: FocusNode(),
          child: ListTile(
            tileColor: Colors.black,
            selected: index == selectedIndex,
            title: Text(
              result.name,
              style: const TextStyle(color: Colors.white),
            ),
            selectedTileColor: Colors.tealAccent,
            onTap: () async {
              selectedIndex = index;
              close(context, null);
              Process.run(result.path, []);
            },
            focusColor: Colors.teal,
          ),
        );
      },
    );
  }

  List<String> _getExecutable() {
    List<String> executables = [];

    for (var d in Platform.environment['PATH']!
        .split(Platform.isWindows ? ";" : ":")) {
      Directory dir = Directory(d);
      if (dir.existsSync()) {
        executables.addAll(dir
            .listSync()
            .whereType<File>()
            .where((file) =>
                file.existsSync() &&
                file.uri.pathSegments.last
                    .endsWith(Platform.isWindows ? ".exe" : ''))
            .map((file) => file.uri.pathSegments.last));
      }
    }
    return executables;
  }
}
