// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:junction/core/junction_search_bar.dart';


void main() {
  testWidgets('SearchBar return of text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    var SUT = JunctionSearchBar(numberOfResult: 0);
    var DOC =  MaterialApp(home : SUT);
    await tester.pumpWidget(DOC);
    assert(SUT.height == 50);
  });


  testWidgets('SearchBar return of text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    var SUT = JunctionSearchBar(numberOfResult: 1);
    var DOC =  MaterialApp(home : SUT);
    await tester.pumpWidget(DOC);
    assert(SUT.height == 100);
  });



}




