# Flutter Testing Assignment

## 📌 Overview

This project demonstrates structured widget testing in a Flutter application.

It includes:

- Favorites feature testing
- Scroll behavior validation
- Test isolation handling
- Refactoring for maintainable automation
- Reusable test utilities

The project showcases both a basic implementation and an improved, scalable refactored approach.

---

## 📁 Project Structure

### `lib/main.dart`
Contains the main application logic:
- Displays a scrollable list of items (Item 0, Item 1, etc.)
- Allows adding items to Favorites
- Provides navigation to Favorites screen
- Supports removal of items from Favorites

---

## 🧪 Test Files

### `test/basic_app_test.dart`

This file contains the initial test implementation with direct widget interactions.

It covers:

- Adding items to favorites
- Removing items from favorites
- Preventing duplicate additions
- Empty favorites validation
- Scroll behavior testing
- Navigation validation
  
---

### `test/refactored_app_test.dart`

This file contains the improved and scalable version of the test suite.

Enhancements include:

- Reusable helper methods
- Reduced duplication
- Cleaner test readability
- Improved maintainability
- Better separation of test logic and test actions

---

### `test/test_utils.dart`

Contains reusable test utilities used by the refactored tests:

- `addItemsToFavorites()` – Add multiple items
- `removeItemsFromFavorites()` – Remove multiple items
- `navigateToFavorites()` – Navigation helper
- `scrollUntilVisible()` – Scroll utility
- `scrollUntilVisibleAndTap()` – Combined scroll + tap helper

This abstraction improves scalability and reduces repetitive code.

---
