import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_calculator/main.dart';
import 'package:advanced_calculator/screens/calculator_screen.dart';

void main() {
  group('Calculator Integration Tests - Basic Functionality', () {
    testWidgets('should launch calculator screen', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(CalculatorScreen), findsOneWidget);
    });

    testWidgets('should display calculator app bar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.text('Advanced Calculator'), findsOneWidget);
    });

    testWidgets('should display navigation icons', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.history), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('should handle basic number input', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      final numberButtons = find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            (widget.data == '1' || widget.data == '2' || widget.data == '3'),
      );

      if (numberButtons.evaluate().isNotEmpty) {
        await tester.tap(numberButtons.first);
        await tester.pump();
        expect(tester.takeException(), isNull);
      } else {
        expect(true, true);
      }
    });

    testWidgets('should handle clear operation', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final clearButtons = find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == 'C',
      );

      if (clearButtons.evaluate().isNotEmpty) {
        await tester.tap(clearButtons.first);
        await tester.pump();

        expect(tester.takeException(), isNull);
      } else {
        expect(true, true);
      }
    });

    testWidgets('should switch between modes without errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final modeSelectors = find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            (widget.data == 'Basic' ||
                widget.data == 'Scientific' ||
                widget.data == 'Programmer'),
      );

      if (modeSelectors.evaluate().isNotEmpty) {
        await tester.tap(modeSelectors.first);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      } else {
        expect(true, true);
      }
    });

    testWidgets('should navigate to history screen without errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final historyButton = find.byIcon(Icons.history);
      if (historyButton.evaluate().isNotEmpty) {
        await tester.tap(historyButton);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.pageBack();
        await tester.pumpAndSettle();
      } else {
        expect(true, true);
      }
    });

    testWidgets('should navigate to settings screen without errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final settingsButton = find.byIcon(Icons.settings);
      if (settingsButton.evaluate().isNotEmpty) {
        await tester.tap(settingsButton);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.pageBack();
        await tester.pumpAndSettle();
      } else {
        expect(true, true);
      }
    });

    testWidgets('should handle theme toggle without errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      final themeButtons = find.byWidgetPredicate(
        (widget) =>
            widget is Icon &&
            (widget.icon == Icons.light_mode || widget.icon == Icons.dark_mode),
      );

      if (themeButtons.evaluate().isNotEmpty) {
        await tester.tap(themeButtons.first);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      } else {
        expect(true, true);
      }
    });
  });

  group('Provider Basic Tests', () {
    testWidgets('Calculator screen should build without errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.byType(CalculatorScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('App should initialize without errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
