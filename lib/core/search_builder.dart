import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:junction/core/io/file_interface.dart';
import 'package:junction/core/junction_search_bar.dart';

///The class builds a suggestion engine for [JunctionSearchBar], using the history
///and the executable on the device.
///
/// It reads [assets/history.json] and [assets/executable.json] for the necessary data
class SearchBuilder {
  late FileInterface? _history;
  late FileInterface _executable;
  late BuildContext _context;
  late  SearchController _controller;
  SearchBuilder(BuildContext context, SearchController controller) {
    _history = FileInterface("assets/history.json", "history.json");
    _executable = FileInterface("assets/executable.json", "executable.json");
    _context = context;
    _controller = controller;
  }

  //ctor testing
  SearchBuilder.testing(this._history, this._executable);

  ///It generates a list of widget containing the suggestion for [JunctionSearchBar] of a specified [length]
  ///
  /// Throws a [ArgumentError] if [length] >= 0
  Future<List<Widget>> generateSearch(int length) async {
    List<ListTile> res = [];
    if(length <= 0) {
      throw ArgumentError("Length must be > 0");
    }
    var stringFileData = await _history!.ensureInitialized!;

    var jsonFileData = jsonDecode(stringFileData!);

    int i = 0;
    if (!jsonFileData.containsKey('history')) {
      return res;
    }
    var historyList = jsonFileData['history'] as List<dynamic>;
    while (i < length && i < historyList.length) {
      res.add(ListTile(title: Text(historyList[i]),
      onTap: () {
        _controller.closeView(historyList[i]);
      }));
      i++;
    }

    var exec = await _executable.ensureInitialized!;
    var exeJson = jsonDecode(exec!);
    if (!exeJson.containsKey('executable')) {
      return res;
    }
    var executableList = exeJson['executable'] as List<dynamic>;
    while (i < length && i < executableList.length) {
      res.add(ListTile(title: Text(executableList[i]),
          onTap: () {
            _controller.closeView(executableList[i]);
          }));
      i++;
    }
    return res;
  }

}
