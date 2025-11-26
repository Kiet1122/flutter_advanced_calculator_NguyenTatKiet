import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/display_area.dart';
import '../widgets/mode_selector.dart';
import '../widgets/button_grid.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Calculator'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(themeProvider.settings.isDarkMode 
                ? Icons.light_mode 
                : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Mode selector
          ModeSelector(
            currentMode: calculatorProvider.currentMode,
            onModeChanged: (mode) {
              calculatorProvider.setMode(mode);
            },
            isSecondFunction: calculatorProvider.isSecondFunction,
            onSecondFunctionToggled: () {
              calculatorProvider.toggleSecondFunction();
            },
          ),
          const SizedBox(height: 16),
          DisplayArea(
            currentExpression: calculatorProvider.currentExpression,
            previousResult: calculatorProvider.previousResult,
            isRadiansMode: themeProvider.settings.useRadians,
            hasMemory: calculatorProvider.memoryValue != 0,
            onClear: () {
              calculatorProvider.clearAll();
            },
            onDeleteLast: () {
              calculatorProvider.deleteLastCharacter();
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ButtonGrid(
              onButtonPressed: (text) {
                calculatorProvider.handleButtonPress(text);
              },
              currentMode: calculatorProvider.currentMode,
              isSecondFunction: calculatorProvider.isSecondFunction,
            ),
          ),
        ],
      ),
    );
  }
}