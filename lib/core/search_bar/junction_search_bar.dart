import 'dart:io';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:provider/provider.dart';

import '../junction_model.dart';

class JunctionSearchBar extends StatelessWidget {
  static double height = 50;
  final int suggestedLength;
  const JunctionSearchBar({Key? key, required this.suggestedLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (suggestedLength <= 0) {
      throw ArgumentError("Length must be > 0");
    }
    final JunctionModel junctionModel = Provider.of<JunctionModel>(context);
    return SearchAnchor(
      viewConstraints: BoxConstraints(
          maxHeight: suggestedLength * (2 + height),
          maxWidth: junctionModel.junctionSettings.junctionBarWidth),
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
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
          ),
        );
      },
      suggestionsBuilder:
          (BuildContext context, SearchController controller) async {
        List<String> executables = [];
        var fuseSearch = Fuzzy(executables,
                options: FuzzyOptions(findAllMatches: true, tokenize: true))
            .search(controller.text);
        debugPrint(controller.text);
        for (var d in Platform.environment['PATH']!
            .split(Platform.isWindows ? ";" : ":")) {
          executables.addAll(Directory(d)
              .listSync()
              .whereType<File>()
              .where((file) => file.existsSync())
              .map((file) => file.uri.pathSegments.last));
        }
        return List<ListTile>.generate(
          fuseSearch.length,
          (index) {
            final String item = executables[index];
            return ListTile(
              title: Text(item),
              onTap: () async {
                controller.closeView("");
                await Process.run(item, []);
              },
            );
          },
        );
      },
    );
  }
}
