import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:junction/core/io/file_interface.dart';
import 'dart:math';

///The class builds a suggestion engine for [JunctionSearchBar], using the history
///and the executable on the device.
///
/// It reads [assets/history.json] and [assets/executable.json] for the necessary data
class SearchBuilder {
  late FileInterface? _history;
  late FileInterface _executable;

  SearchBuilder(SearchController controller) {
    _history = FileInterface("assets/history.json", "history.json");
    _executable = FileInterface("assets/executable.json", "executable.json");
  }

  //ctor testing
  SearchBuilder.testing(this._history, this._executable);

  ///It generates a list of widget containing the suggestion for [JunctionSearchBar] of a specified [length]
  ///
  /// Throws a [ArgumentError] if [length] >= 0
  Future<List<Widget>> generateSearch(
      SearchController controller, int length) async {
    List<String> res = [];
    if (length <= 0) {
      throw ArgumentError("Length must be > 0");
    }

    var stringFileData = await _history!.ensureInitialized!;

    var jsonFileData = jsonDecode(stringFileData!);

    int i = 0;
    if (!jsonFileData.containsKey('history')) {
      return [];
    }
    var historyList = jsonFileData['history'] as List<dynamic>;
    while (i < length && i < historyList.length) {
      res.add(historyList[i]);
      i++;
    }

    var exec = await _executable.ensureInitialized!;
    var exeJson = jsonDecode(exec!);

    var executableList = exeJson['executable'] as List<dynamic>;
    i = 0;
    while (i < min(length - historyList.length, executableList.length)) {
      res.add(executableList[i]);
      i++;
    }
    return List<ListTile>.generate(res.length, (index) {
      final String item = res[index];
      return ListTile(
        title: Text(item),
        onTap: () {
          controller.closeView(item);
        },
        trailing: const Icon(Icons.history),
      );
    });
  }
}
