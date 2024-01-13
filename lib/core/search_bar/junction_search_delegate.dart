import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';

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

    return ListView.builder(
      itemCount: executables.length,
      itemBuilder: (context, index) {
        var result = executables[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

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

    var fuseSearch = Fuzzy(executables,
            options: FuzzyOptions(findAllMatches: true, tokenize: true))
        .search(query);
    return ListView.builder(
      itemCount: fuseSearch.length,
      itemBuilder: (context, index) {
        var result = fuseSearch[index];
        return ListTile(
          title: Text(result.item),
        );
      },
    );
  }
}

    // return SearchAnchor(
    //   viewConstraints: BoxConstraints(
    //       maxHeight: suggestedLength * (2 + height),
    //       maxWidth: junctionModel.junctionSettings.junctionBarWidth),
    //   dividerColor: Colors.black87,
    //   builder: (BuildContext context, SearchController controller) {
    //     return Directionality(
    //       textDirection: TextDirection.ltr,
    //       child: SearchBar(
    //         controller: controller,
    //         onTap: () {
    //           junctionModel.expandIfNot(height * suggestedLength);
    //           EasyDebounce.debounce('deb', const Duration(milliseconds: 150),
    //               () {
    //             controller.openView();
    //           });
    //         },
    //         onChanged: (_) {
    //           controller.openView();
    //         },
    //         leading: const Icon(Icons.search),
    //       ),
    //     );
    //   },
    //   suggestionsBuilder:
    //       (BuildContext context, SearchController controller) async {
    //     List<String> executables = [];
    //     debugPrint(controller.text);
    //     for (var d in Platform.environment['PATH']!
    //         .split(Platform.isWindows ? ";" : ":")) {
    //       Directory dir = Directory(d);
    //       if (dir.existsSync()) {
    //         executables.addAll(dir
    //             .listSync()
    //             .whereType<File>()
    //             .where((file) =>
    //                 file.existsSync() &&
    //                 file.uri.pathSegments.last
    //                     .endsWith(Platform.isWindows ? ".exe" : ''))
    //             .map((file) => file.uri.pathSegments.last));
    //       }
    //     }
    //     debugPrint(controller.text);

    //     var fuseSearch = Fuzzy(executables,
    //             options: FuzzyOptions(findAllMatches: true, tokenize: true))
    //         .search(controller.text);
    //     return List<ListTile>.generate(
    //       fuseSearch.length,
    //       (index) {
    //         final String item = executables[index];
    //         return ListTile(
    //           title: Text(item),
    //           onTap: () async {
    //             controller.closeView("");
    //             await Process.run(item, []);
    //           },
    //         );
    //       },
    //     );
    //   },
    // );
 
