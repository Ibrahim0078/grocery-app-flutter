// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grocery_mart/main.dart';

void main() {
  testWidgets('Grocery Store app launches correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GroceryStoreApp());

    // Wait for all animations and async operations to complete
    await tester.pumpAndSettle();

    // Verify that our grocery store app loads with the home screen.
    expect(find.text('Grocery Store'), findsOneWidget);
    expect(find.text('Welcome to Grocery Store! 🛒'), findsOneWidget);

    // These should be present even before data loads
    expect(find.text('Shop by Category'), findsOneWidget);
    expect(find.text('Featured Products'), findsOneWidget);
  });

  testWidgets('Cart icon is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GroceryStoreApp());

    // Wait for all animations and async operations to complete
    await tester.pumpAndSettle();

    // Verify that the cart icon is present in the app bar
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
  });

  testWidgets('Welcome banner is displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GroceryStoreApp());

    // Wait for all animations and async operations to complete
    await tester.pumpAndSettle();

    // Verify that welcome banner content is displayed
    expect(find.text('Fresh products delivered to your door'), findsOneWidget);
  });

  testWidgets('Navigation between tabs works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GroceryStoreApp());

    // Wait for all animations and async operations to complete
    await tester.pumpAndSettle();

    // Tap on Categories tab
    await tester.tap(find.text('Categories'));
    await tester.pumpAndSettle();

    // Verify Categories screen is displayed
    expect(find.text('Categories'), findsOneWidget);
  });

  testWidgets('Search functionality works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GroceryStoreApp());

    // Wait for all animations and async operations to complete
    await tester.pumpAndSettle();

    // Tap on Search tab
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    // Verify Search screen is displayed
    expect(find.text('Search Products'), findsOneWidget);
  });
}
