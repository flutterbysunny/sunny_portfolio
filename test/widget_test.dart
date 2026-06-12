import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_portfolio/core/constants/app_constants.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/core/theme/theme_provider.dart';
import 'package:flutter_portfolio/shared/widgets/shared_widgets.dart';

void main() {
  group('AppConstants', () {
    test('name is not empty', () {
      expect(AppConstants.name.isNotEmpty, true);
    });

    test('email contains @', () {
      expect(AppConstants.email.contains('@'), true);
    });

    test('navItems has 5 items', () {
      expect(AppConstants.navItems.length, 5);
    });
  });

  group('ThemeNotifier', () {
    test('starts in dark mode', () {
      final container = ProviderContainer();
      final themeMode = container.read(themeProvider);
      expect(themeMode, ThemeMode.dark);
      container.dispose();
    });

    test('toggles to light mode', () {
      final container = ProviderContainer();
      container.read(themeProvider.notifier).toggleTheme();
      expect(container.read(themeProvider), ThemeMode.light);
      container.dispose();
    });

    test('toggles back to dark mode', () {
      final container = ProviderContainer();
      container.read(themeProvider.notifier).toggleTheme();
      container.read(themeProvider.notifier).toggleTheme();
      expect(container.read(themeProvider), ThemeMode.dark);
      container.dispose();
    });
  });

  group('GradientText Widget', () {
    testWidgets('renders with correct text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: const Scaffold(
            body: GradientText('Hello Flutter'),
          ),
        ),
      );

      expect(find.text('Hello Flutter'), findsOneWidget);
    });
  });

  group('TechTag Widget', () {
    testWidgets('renders label correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: const Scaffold(
            body: TechTag('Flutter'),
          ),
        ),
      );

      expect(find.text('Flutter'), findsOneWidget);
    });
  });

  group('SectionHeading Widget', () {
    testWidgets('renders label and title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: const Scaffold(
            body: SingleChildScrollView(
              child: SectionHeading(
                label: 'Test Label',
                title: 'Test Title',
              ),
            ),
          ),
        ),
      );

      expect(find.text('TEST LABEL'), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
    });
  });
}
