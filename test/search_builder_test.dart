import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:junction/core/io/file_interface.dart';
import 'package:junction/core/search_builder.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_builder_test.mocks.dart';

@GenerateMocks([FileInterface])
void main() {
  group('Search builder', () {
    test('history', () async {
      // Arrange
      final MockFileInterface doc = MockFileInterface();
      final MockFileInterface doc_s = MockFileInterface();

      when(doc.ensureInitialized).thenAnswer((_) async => jsonEncode({
            'history': ['peppo', 'dwm', 'junction']
          }));
      when(doc_s.ensureInitialized).thenAnswer((_) async => jsonEncode({
            'executable': ['ampl', 'bestie', 'carbon']
          }));
      // Act
      final SearchBuilder SUT = SearchBuilder.testing(doc, doc_s);
      final List<Widget> result = await SUT.generateSearch(3);

      expect(result, isList); // Ensure it's a list

      final List<String> textValues = result.map((widget) {
        if (widget is ListTile) {
          final titleWidget = widget.title;
          if (titleWidget is Text) {
            return titleWidget.data ?? '';
          }
        }
        return '';
      }).toList();
      expect(textValues, ['peppo', 'dwm', 'junction']);
      expect(textValues.length, 3);
    });

    test('ExecutableAfterHistory', () async {
      // Arrange
      final MockFileInterface doc = MockFileInterface();
      final MockFileInterface docS = MockFileInterface();

      when(doc.ensureInitialized).thenAnswer((_) async => jsonEncode({
            'history': ['peppo', 'dwm', 'junction']
          }));
      when(docS.ensureInitialized).thenAnswer((_) async => jsonEncode({
            'executable': ['ampl', 'bestie', 'carbon']
          }));
      // Act
      final SearchBuilder SUT = SearchBuilder.testing(doc, docS);
      final List<Widget> result = await SUT.generateSearch(5);

      final List<String> textValues = result.map((widget) {
        if (widget is ListTile) {
          final titleWidget = widget.title;
          if (titleWidget is Text) {
            return titleWidget.data ?? '';
          }
        }
        return '';
      }).toList();
      expect(textValues, ['peppo', 'dwm', 'junction', 'ampl', 'bestie']);
    });
  });
}
