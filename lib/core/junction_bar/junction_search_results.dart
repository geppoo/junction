import 'dart:io';
import 'package:get/get.dart';
import 'package:win32_registry/win32_registry.dart';

class JunctionSearchResults {
  List<SearchResult> _searchResults = [];

  JunctionSearchResults(this._searchResults);

  JunctionSearchResults.customPathWithExecutables(List<String> customPaths) {
    _getPathExecutables();
    customPaths.where((e) => Directory(e).existsSync()).forEach(
          (element) => _searchResults.addAll(Directory(element)
              .listSync(recursive: true, followLinks: true)
              .map(
                (e) => SearchResult(e.uri.pathSegments.last, e.path),
              )),
        );
  }

  JunctionSearchResults.executable() {
    _getPathExecutables();
  }

  List<SearchResult> getPathExecutable() {
    return _searchResults;
  }

  void _getPathExecutables() {
    if (Platform.isWindows) {
      const keyPath = r"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall";
      final key = Registry.openPath(RegistryHive.localMachine, path: keyPath);

      for (var subKey in key.subkeyNames) {
        var newKeyPath =
            r"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\" + subKey;
        final newKey =
            Registry.openPath(RegistryHive.localMachine, path: newKeyPath);
        if (newKey.getValueAsString("InstallLocation") != null) {
          _searchResults.add(SearchResult(
              subKey, newKey.getValueAsString("InstallLocation")!));
        }
      }
    } else {
      Platform.environment['PATH']!
          .split(":")
          .where((element) => Directory(element).existsSync())
          .map((e) => Directory(e).listSync().map(
                (e) => SearchResult.single(e.uri.pathSegments.last),
              ))
          .forEach(
            (element) => _searchResults.addAll(element),
          );
    }
  }
}

final class SearchResult {
  late final String name;

  late final String path;

  SearchResult(this.name, this.path);

  SearchResult.single(String name) {
    this.name = path = name;
  }
}
