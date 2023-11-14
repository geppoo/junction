import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:junction/core/io/file_interface.dart';
import 'package:junction/core/search_builder.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'search_builder_test.mocks.dart';

@GenerateMocks([FileInterface, SearchController, BuildContext])
void main() {
  group('Search builder', () {
    final MockFileInterface doc = MockFileInterface();
    final MockFileInterface docS = MockFileInterface();
    final MockSearchController docSc = MockSearchController();

    test('history', () async {
      // Arrange

      when(doc.ensureInitialized).thenAnswer((_) async => jsonEncode({
            'history': ['peppo', 'dwm', 'junction']
          }));
      when(docS.ensureInitialized).thenAnswer((_) async => jsonEncode({
            'executable': ['ampl', 'bestie', 'carbon']
          }));
      // Act
      final SearchBuilder SUT = SearchBuilder.testing(doc, docS);
      final List<Widget> result = await SUT.generateSearch(docSc, 3);

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

      when(doc.ensureInitialized).thenAnswer((_) async => jsonEncode({
            'history': ['peppo', 'dwm', 'junction']
          }));
      when(docS.ensureInitialized).thenAnswer((_) async => jsonEncode({
            'executable': ['ampl', 'bestie', 'carbon']
          }));
      // Act
      final SearchBuilder SUT = SearchBuilder.testing(doc, docS);
      final List<Widget> result = await SUT.generateSearch(docSc, 5);

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

    testWidgets('tap test', (WidgetTester tester) async {
      when(doc.ensureInitialized).thenAnswer((_) async => jsonEncode({
            'history': ['peppo', 'dwm', 'junction']
          }));
      when(docS.ensureInitialized).thenAnswer((_) async => jsonEncode({
            'executable': ['ampl', 'bestie', 'carbon']
          }));
      // Act
      final SearchBuilder SUT = SearchBuilder.testing(doc, docS);
      final List<Widget> result = await SUT.generateSearch(docSc, 5);

      await tester.pumpWidget(Material(
          child: Directionality(
              textDirection: TextDirection.ltr, child: result.first)));
      await tester.tap(find.byType(ListTile));
      verify(docSc.closeView('peppo'));
    });
  });
}
