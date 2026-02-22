// This file demonstrates refactored tests using reusable utilities
// to improve scalability and maintainability.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/main.dart';
import 'test_utils.dart';

void main() {
  group('Testing App - Refactored Version', () {

    testWidgets('Favorites operations test', (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();

      await addItemsToFavorites(
        tester,
        startIndex: 0,
        endIndex: 2,
      );

      await tester.pump(); 
      expect(find.text('Added to favorites.'), findsOneWidget);

      await navigateToFavorites(tester);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('remove_icon_0')), findsOneWidget);

      await removeItemsFromFavorites(
        tester,
        startIndex: 0,
        endIndex: 2,
      );

      await tester.pumpAndSettle();

      expect(find.text('Item 0'), findsNothing);
      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Item 2'), findsNothing);
      
    });


    testWidgets('Item cannot be added twice to favorites', (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      // Tapping same icon twice
      await scrollUntilVisibleAndTap(
        tester,
        find.byKey(const ValueKey('icon_1')),
      );

      await scrollUntilVisibleAndTap(
        tester,
        find.byKey(const ValueKey('icon_1')),
      );
      // Navigate to Favorites
      await navigateToFavorites(tester);
      // Item should not appear now
      expect(find.text('Item 1'), findsNothing);
    });


    testWidgets('Favorites page shows no items when list is empty',
        (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();

      await navigateToFavorites(tester);
      // Verify we are on Favorites page and no items are shown
      expect(find.text('Favorites'), findsOneWidget);
      expect(find.byType(ListTile), findsNothing);
    });


    testWidgets('Correct number of items appear in favorites',
        (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      // Add 2 items to favorites
      await addItemsToFavorites(
        tester,
        startIndex: 0,
        endIndex: 1,
      );

      await navigateToFavorites(tester);
      // Verify both items are shown in favorites
      expect(find.byType(ListTile), findsNWidgets(2));
    });


    testWidgets('Removing one favorite does not affect others',
        (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      // Add 2 items to favorites
      await addItemsToFavorites(
        tester,
        startIndex: 0,
        endIndex: 1,
      );

      await navigateToFavorites(tester);
      // Remove first item
      await scrollUntilVisibleAndTap(
        tester,
        find.byKey(const ValueKey('remove_icon_0')),
      );
      // Verify first item is removed but second item still exists
      expect(find.byKey(const ValueKey('remove_icon_1')), findsOneWidget);
    });


    testWidgets('Home page scrolls until Item 20 is visible',
        (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      await scrollUntilVisible(
        tester,
        find.text('Item 20'),
      );
      expect(find.text('Item 20'), findsOneWidget);
    });


    testWidgets('Favorites scroll test', (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      // Add items 0 to 25
      await addItemsToFavorites(
        tester,
        startIndex: 0,
        endIndex: 25,
      );
      await navigateToFavorites(tester);
      // Scroll until Item 20 appears
      await scrollUntilVisible(
        tester,
        find.text('Item 20'),
      );
      expect(find.text('Item 20'), findsOneWidget);
    });

  });
}