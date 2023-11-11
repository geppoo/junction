import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/search_anchor.dart';
import 'package:junction/core/io/file_interface.dart';

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

  Future<List<Widget>> generateSearch(int len) async {
    List<ListTile> res = [];

    var stringFileData = await _history!.ensureInitialized!;

    var jsonFileData = jsonDecode(stringFileData!);

    int i = 0;
    if (!jsonFileData.containsKey('history')) {
      return res;
    }
    var historyList = jsonFileData['history'] as List<dynamic>;
    while (i < len && i < historyList.length) {
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
    while (i < len && i < executableList.length) {
      res.add(ListTile(title: Text(executableList[i]),
          onTap: () {
            _controller.closeView(executableList[i]);
          }));
      i++;
    }
    return res;
  }
  //suggestionsBuilder:
  //(BuildContext context, SearchController controller) {
  //return List<ListTile>.generate(5, (int index) {
  //final String item = 'item $index';
  //return ListTile(
  //title: Text(item),
  //onTap: () {
  //setState(() {
  //controller.closeView(item);
  //});
  //},
  //);
}
