import 'dart:convert';
import 'dart:math';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:junction/core/io/file_interface.dart';
import 'package:provider/provider.dart';

import '../../config/model/junction_model.dart';

class JunctionSearchBar extends StatelessWidget {
  final int suggestedLength;
  static double height = 50;
  const JunctionSearchBar({Key? key, required this.suggestedLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              EasyDebounce.debounce('deb', const Duration(milliseconds: 150), () {
                controller.openView();
              });
            },
            onChanged: (_) {},
            leading: const Icon(Icons.search),
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) async{
        final FileInterface history =  FileInterface.history();
        final FileInterface executable= FileInterface.executable();

        List<String> res = [];
        if (suggestedLength <= 0) {
          throw ArgumentError("Length must be > 0");
        }

        var stringFileData = await history.ensureInitialized!;

        var jsonFileData = jsonDecode(stringFileData!);

        int i = 0;
        if (!jsonFileData.containsKey('history')) {
          return [];
        }
        var historyList = jsonFileData['history'] as List<dynamic>;
        while (i < suggestedLength && i < historyList.length) {
          res.add(historyList[i]);
          i++;
        }

        var exec = await executable.ensureInitialized!;
        var exeJson = jsonDecode(exec!);

        var executableList = exeJson['executable'] as List<dynamic>;
        i = 0;
        while (i < min(suggestedLength - historyList.length, executableList.length)) {
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
      },
    );
  }
}
