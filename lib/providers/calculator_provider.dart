import 'package:flutter/material.dart';
import '../models/calculator_mode.dart';
import '../models/calculation_history.dart';
import '../utils/calculator_logic.dart';
import 'history_provider.dart';
import 'theme_provider.dart';

/// Manages calculator state and business logic
class CalculatorProvider with ChangeNotifier {
  String _currentExpression = '';
  String _previousResult = '';
  double _memoryValue = 0.0;
  CalculatorMode _currentMode = CalculatorMode.basic;
  bool _isSecondFunction = false;
  
  String get currentExpression => _currentExpression;
  String get previousResult => _previousResult;
  double get memoryValue => _memoryValue;
  CalculatorMode get currentMode => _currentMode;
  bool get isSecondFunction => _isSecondFunction;
  
  late HistoryProvider _historyProvider;
  late ThemeProvider _themeProvider;
  
  CalculatorProvider({
    required HistoryProvider historyProvider,
    required ThemeProvider themeProvider,
  }) {
    _historyProvider = historyProvider;
    _themeProvider = themeProvider;
  }
  
  /// Updates provider dependencies
  void updateDependencies(ThemeProvider themeProvider, HistoryProvider historyProvider) {
    _themeProvider = themeProvider;
    _historyProvider = historyProvider;
  }
  
  /// Changes calculator mode
  void setMode(CalculatorMode mode) {
    _currentMode = mode;
    _isSecondFunction = false;
    notifyListeners();
  }
  
  /// Toggles second function mode
  void toggleSecondFunction() {
    _isSecondFunction = !_isSecondFunction;
    notifyListeners();
  }
  
  /// Handles button press events
  void handleButtonPress(String buttonText) {
    if (buttonText == 'C') {
      clearAll();
      return;
    }
    
    final newExpression = CalculatorLogic.handleButtonPress(
      _currentExpression,
      buttonText,
      _currentMode,
      memoryValue: _memoryValue,
      useRadians: _themeProvider.settings.useRadians,
      isSecondFunction: _isSecondFunction,
    );
    
    if (buttonText == '=' && !newExpression.startsWith('Error')) {
      final calculation = CalculationHistory(
        expression: _currentExpression,
        result: newExpression,
        timestamp: DateTime.now(),
        mode: _currentMode,
      );
      _historyProvider.addCalculation(calculation);
      _previousResult = newExpression;
    }
    
    if (buttonText == 'MC') {
      _memoryValue = 0.0;
    } else if (buttonText == 'M+') {
      try {
        final result = _evaluateCurrentExpression();
        if (!result.startsWith('Error')) {
          _memoryValue += double.parse(result);
        }
      } catch (e) {
        // Handle calculation errors silently
      }
    } else if (buttonText == 'M-') {
      try {
        final result = _evaluateCurrentExpression();
        if (!result.startsWith('Error')) {
          _memoryValue -= double.parse(result);
        }
      } catch (e) {
        // Handle calculation errors silently
      }
    }
    
    _currentExpression = newExpression;
    notifyListeners();
  }
  
  /// Evaluates current expression
  String _evaluateCurrentExpression() {
    return CalculatorLogic.handleButtonPress(
      _currentExpression,
      '=',
      _currentMode,
      useRadians: _themeProvider.settings.useRadians,
      isSecondFunction: _isSecondFunction,
    );
  }
  
  /// Clears current expression
  void clearExpression() {
    _currentExpression = '';
    notifyListeners();
  }
  
  /// Clears all calculator state
  void clearAll() {
    _currentExpression = '';
    _previousResult = '';
    notifyListeners();
  }
  
  /// Sets expression from history
  void setExpression(String expression) {
    _currentExpression = expression;
    notifyListeners();
  }
  
  /// Deletes last character from expression
  void deleteLastCharacter() {
    if (_currentExpression.isNotEmpty) {
      _currentExpression = _currentExpression.substring(0, _currentExpression.length - 1);
      notifyListeners();
    }
  }
}