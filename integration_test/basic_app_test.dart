// This file demonstrates the initial basic integration tests
// written without utility abstraction for clarity of core logic.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/main.dart';

void main() {
  group('Testing App', () {
    testWidgets('Favorites operations test', (tester) async {
      await tester.pumpWidget(const TestingApp());

      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];

      for (var icon in iconKeys) {
        await tester.tap(find.byKey(ValueKey(icon)));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('Added to favorites.'), findsOneWidget);
      }

      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      final removeIconKeys = [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
      ];

      for (final iconKey in removeIconKeys) {
        await tester.tap(find.byKey(ValueKey(iconKey)));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('Removed from favorites.'), findsOneWidget);
      }
    });


    testWidgets('Item cannot be added twice to favorites', (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      // Tapping same icon twice
      await tester.tap(find.byKey(const ValueKey('icon_1')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.byKey(const ValueKey('icon_1')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      // Navigate to Favorites
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      // Item should not appear now
      expect(find.text('Item 1'), findsNothing);
    });

    testWidgets('Favorites page shows no items when list is empty', (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      // Navigate to Favorites
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      // Verify we are on Favorites page
      expect(find.text('Favorites'), findsOneWidget);
      // Verify no favorite items are shown
      expect(find.byKey(const ValueKey('remove_icon_0')), findsNothing);
      expect(find.byKey(const ValueKey('remove_icon_1')), findsNothing);
      expect(find.byKey(const ValueKey('remove_icon_2')), findsNothing);
    });

    testWidgets('Correct number of items appear in favorites', (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      //mark item 0 as favorite
      await tester.tap(find.byKey(const ValueKey('icon_0')));
      await tester.pumpAndSettle();
      //mark item 1 as favorite
      await tester.tap(find.byKey(const ValueKey('icon_1')));
      await tester.pumpAndSettle();
      // Navigate to Favorites
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      // Verify both items are shown in favorites
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('Removing one favorite does not affect others', (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      //mark item 0 as favorite
      await tester.tap(find.byKey(const ValueKey('icon_0')));
      //mark item 1 as favorite
      await tester.tap(find.byKey(const ValueKey('icon_1')));
      await tester.pumpAndSettle();
      // Navigate to Favorites
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      // Remove item 0 from favorites
      await tester.tap(find.byKey(const ValueKey('remove_icon_0')));
      await tester.pumpAndSettle();
      // Verify item 0 is removed but item 1 still exists
      expect(find.byKey(const ValueKey('remove_icon_1')), findsOneWidget);
    });

  testWidgets('Home page scrolls until Item 20 is visible', (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      // Item 20 should not be visible
      expect(find.text('Item 20'), findsNothing);
      // Scroll until Item 20 appears
      await tester.scrollUntilVisible(
        find.text('Item 20'),
        300.0,
        scrollable: find.byType(Scrollable),
      );
      // Verify Item 20 is visible
      expect(find.text('Item 20'), findsOneWidget);
    });

    testWidgets('Favorites scroll test', (tester) async {
      await tester.pumpWidget(const TestingApp());
      await tester.pumpAndSettle();
      // Add items 0 to 25 
      for (int i = 0; i <= 25; i++) {
        final iconFinder = find.byKey(ValueKey('icon_$i'));
        await tester.scrollUntilVisible(
          iconFinder,
          300.0,
          scrollable: find.byType(Scrollable),
        );
        await tester.tap(iconFinder);
        await tester.pumpAndSettle();
      }
          // Navigate to Favorites
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      // Scroll inside Favorites page to Item 20
      await tester.scrollUntilVisible(
        find.text('Item 20'),
        300.0,
        scrollable: find.byType(Scrollable),
      );

      // Verify Item 20 is visible in Favorites
      expect(find.text('Item 20'), findsOneWidget);
    });

  
  });
}