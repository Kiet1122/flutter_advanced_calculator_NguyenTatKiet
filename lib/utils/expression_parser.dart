import 'package:math_expressions/math_expressions.dart';

class ExpressionParser {
  static String evaluateExpression(
    String expression, {
    bool useRadians = false,
  }) {
    try {
      if (expression.isEmpty) return '';

      if (_isInvalidExpression(expression)) {
        return 'Error: Invalid expression';
      }

      String cleanExpression = _cleanExpression(
        expression,
        useRadians: useRadians,
      );

      Parser p = Parser();
      Expression exp = p.parse(cleanExpression);
      ContextModel cm = ContextModel();

      double result = exp.evaluate(EvaluationType.REAL, cm);

      if (result.isInfinite) {
        return 'Error: Division by zero';
      }
      if (result.isNaN) {
        return 'Error: Invalid operation';
      }

      return _formatResult(result);
    } catch (e) {
      return 'Error: Invalid expression';
    }
  }

  static String _cleanExpression(String expression, {bool useRadians = false}) {
    String cleanExpression = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', '3.141592653589793') 
        .replaceAll('pi', '3.141592653589793')
        .replaceAll('e', '2.718281828459045')
        .replaceAll('√', 'sqrt');

    cleanExpression = _handleImplicitMultiplication(cleanExpression);

    cleanExpression = _handleTrigFunctions(
      cleanExpression,
      useRadians: useRadians,
    );

    return cleanExpression;
  }

  static String _handleImplicitMultiplication(String expression) {
    String result = expression;

    result = result.replaceAllMapped(
      RegExp(r'(\d)(\()'),
      (match) => '${match[1]}*${match[2]}',
    );

    result = result.replaceAllMapped(
      RegExp(r'(\))(\()'),
      (match) => '${match[1]}*${match[2]}',
    );

    return result;
  }

  static String _handleTrigFunctions(
    String expression, {
    bool useRadians = false,
  }) {
    if (useRadians) return expression;

    String result = expression;

    final trigFunctions = ['sin', 'cos', 'tan'];

    for (var func in trigFunctions) {
      result = result.replaceAllMapped(RegExp('$func\\(([^)]+)\\)'), (match) {
        String inner = match.group(1)!;
        if (double.tryParse(inner) != null) {
          return '$func(($inner) * 3.141592653589793 / 180)';
        }
        return match.group(0)!; 
      });
    }

    return result;
  }

  static bool _isInvalidExpression(String expression) {
    if (expression.trim().isEmpty) return true;

    if (_hasInvalidCharacters(expression)) {
      return true;
    }

    final invalidPatterns = [
      '++',
      '--',
      '**',
      '//',
      '/*',
      '*/',
      '+*',
      '-*',
      '*+',
      '*-',
      '+/',
      '-/',
      '/+',
      '/-',
    ];

    for (var pattern in invalidPatterns) {
      if (expression.contains(pattern)) {
        return true;
      }
    }

    final operatorSequence = RegExp(r'[+×÷/*](?=[+×÷/*])');
    if (operatorSequence.hasMatch(expression.replaceAll(' ', ''))) {
      String clean = expression.replaceAll('+-', '').replaceAll('-+', '');
      if (operatorSequence.hasMatch(clean)) {
        return true;
      }
    }

    int open = expression.split('(').length - 1;
    int close = expression.split(')').length - 1;
    if (open != close) return true;

    if (expression.contains('()')) return true;

    return false;
  }

  static bool _hasInvalidCharacters(String expression) {
    final validChars = RegExp(r'^[0-9+\-*/().×÷πesincostanlog√\s]+$');

    String testString = expression
        .replaceAll('sin', '')
        .replaceAll('cos', '')
        .replaceAll('tan', '')
        .replaceAll('log', '')
        .replaceAll('sqrt', '')
        .replaceAll('pi', '')
        .replaceAll('e', '')
        .replaceAll('π', '')
        .replaceAll('√', '')
        .replaceAll(RegExp(r'\s+'), ''); 

    final basicValidChars = RegExp(r'^[0-9+\-*/().×÷]+$');
    if (!basicValidChars.hasMatch(testString)) {
      return true;
    }

    return false;
  }

  static String _formatResult(double result) {
    if (result == result.truncateToDouble()) {
      return result.truncate().toString();
    } else {
      String formatted = result.toStringAsFixed(8);
      formatted = formatted.replaceAll(RegExp(r'0+$'), '');
      formatted = formatted.replaceAll(RegExp(r'\.$'), '');
      return formatted;
    }
  }

  static bool isValidExpression(String expression) {
    if (expression.isEmpty) return false;

    try {
      if (_isInvalidExpression(expression)) {
        return false;
      }

      String cleanExpression = _cleanExpressionForValidation(expression);

      Parser p = Parser();
      p.parse(cleanExpression);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String _cleanExpressionForValidation(String expression) {
    return expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', '3.14159')
        .replaceAll('pi', '3.14159')
        .replaceAll('e', '2.71828')
        .replaceAll('√', 'sqrt')
        .replaceAll('sin', 'sin')
        .replaceAll('cos', 'cos')
        .replaceAll('tan', 'tan')
        .replaceAll('ln', 'log')
        .replaceAll('log10', 'log10');
  }
}
