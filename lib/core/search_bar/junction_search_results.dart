import 'dart:io';

import 'package:win32_registry/win32_registry.dart';

class JunctionSearchResults {
  List<SearchResult> _searchResults = [];

  JunctionSearchResults(this._searchResults);

  JunctionSearchResults.executable() {
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
              subKey, newKey.getValueAsString("InstallLocation") as String));
        }
      }

      ///Get-ChildItem -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ | Get-ItemProperty |
      // ∙ Select-Object DisplayName, DisplayVersion, InstallLocation
      ///  Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ | Get-ItemProperty |
      // ∙ Select-Object DisplayName, DisplayVersion, InstallLocation
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

  List<SearchResult> getPathExecutable() {
    return _searchResults;
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
