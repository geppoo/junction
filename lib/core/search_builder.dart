import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:junction/core/io/file_interface.dart';

class SearchBuilder {
  final FileInterface? _history;
  final FileInterface _executable;

  SearchBuilder(this._history, this._executable);

  Future<List<Widget>> generateSearch(int len) async {
    List<Text> res = [];

    var stringFileData = await _history!.ensureInitialized!;

    var jsonFileData = jsonDecode(stringFileData!);

    int i  = 0;
    if (!jsonFileData.containsKey('history')) {
      return res;
    }
    var historyList = jsonFileData['history'] as List<dynamic>;
    while (i < len && i < historyList.length){
      res.add(
          Text(historyList[i])
      );
      i++;
    }
    var exec = await _executable.ensureInitialized!;
    var exeJson = jsonDecode(exec!);
    if(!exeJson.containsKey('executable')){
      return res;
    }
    var executableList = exeJson['executable'] as List<dynamic>;
    while(i < len){
      res.add(Text(executableList[(i % historyList.length)]));
      i++;
    }
    return res;
  }
}
