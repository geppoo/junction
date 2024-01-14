import 'dart:io';

class JunctionSearchResults {
  late final List<File> path;

  JunctionSearchResults(this.path);

  JunctionSearchResults.executable() {
    Platform.environment['PATH']!
        .split(":")
        .map((e) => Directory(e))
        .where((element) => element.existsSync() && element.runtimeType == File)
        .where(
          (element) => element.existsSync(),
        );
  }

  List<String> getPathExecutatable() {
    return path
        .map(
          (e) => e.uri.pathSegments.last,
        )
        .toList();
  }
}
