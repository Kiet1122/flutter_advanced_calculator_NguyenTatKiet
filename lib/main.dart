import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/history_provider.dart';
import 'providers/calculator_provider.dart';
import 'screens/calculator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => HistoryProvider()),
        ChangeNotifierProxyProvider2<ThemeProvider, HistoryProvider, CalculatorProvider>(
          create: (context) => CalculatorProvider(
            historyProvider: Provider.of<HistoryProvider>(context, listen: false),
            themeProvider: Provider.of<ThemeProvider>(context, listen: false),
          ),
          update: (context, themeProvider, historyProvider, calculatorProvider) {
            return calculatorProvider!..updateDependencies(themeProvider, historyProvider);
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Advanced Calculator',
            theme: themeProvider.currentTheme,
            home: const CalculatorScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}