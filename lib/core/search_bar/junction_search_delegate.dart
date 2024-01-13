import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:provider/provider.dart';

class JunctionSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
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
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> executables = _getExecutable();

    return _buildListView(executables);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    List<String> executables = _getExecutable();
    return _buildListView(Fuzzy(executables,
            options: FuzzyOptions(findAllMatches: true, tokenize: true))
        .search(query)
        .map((e) => e.item.toString())
        .toList());
  }

  ListView _buildListView(List<String> executables) {
    return ListView.builder(
      itemCount: executables.length,
      itemBuilder: (context, index) {
        var result = executables[index];
        return ListTile(
          tileColor: Colors.black,
          title: Text(
            result,
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () async {
            close(context, null);
            Process.run(result, []);
          },
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
