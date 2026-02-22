import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Scrolls until the given finder becomes visible.
Future<void> scrollUntilVisible(
  WidgetTester tester,
  Finder finder,
) async {
  await tester.scrollUntilVisible(
    finder,
    200.0,
    scrollable: find.byType(Scrollable),
  );
}

/// Scrolls until visible and then taps the widget.
Future<void> scrollUntilVisibleAndTap(
  WidgetTester tester,
  Finder finder,
) async {
  await tester.scrollUntilVisible(
    finder,
    200.0,
    scrollable: find.byType(Scrollable),
  );

  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Safely taps a widget if it exists in the widget tree.
Future<void> safeTap(
  WidgetTester tester,
  Finder finder,
) async {
  if (finder.evaluate().isNotEmpty) {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }
}

/// Navigates to the Favorites page.
Future<void> navigateToFavorites(WidgetTester tester) async {
  await tester.tap(find.text('Favorites'));
  await tester.pumpAndSettle();
}

/// Adds multiple items to favorites using scroll + tap.
Future<void> addItemsToFavorites(
  WidgetTester tester, {
  required int startIndex,
  required int endIndex,
}) async {
  for (int i = startIndex; i <= endIndex; i++) {
    final iconFinder = find.byKey(ValueKey('icon_$i'));

    await scrollUntilVisibleAndTap(tester, iconFinder);
  }
}

/// Removes multiple items from favorites page.
Future<void> removeItemsFromFavorites(
  WidgetTester tester, {
  required int startIndex,
  required int endIndex,
}) async {
  for (int i = startIndex; i <= endIndex; i++) {
    await tester.tap(find.byKey(ValueKey('remove_icon_$i')));
  }
}
