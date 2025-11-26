import 'package:advanced_calculator/models/calculator_mode.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

class CalculatorLogic {
  static const List<String> basicOperations = ['+', '-', '×', '÷', '%'];
  static const List<String> scientificFunctions = [
    'sin', 'cos', 'tan', 'asin', 'acos', 'atan', 
    'ln', 'log', '√', 'log₂', 'e^', '10^', 'x³', '∛', '|x|', 'n!', 'mod'
  ];
  static const List<String> scientificConstants = ['π', 'e'];
  static const List<String> programmerOperations = [
    'AND', 'OR', 'XOR', 'NOT', '<<', '>>'
  ];

  static String handleButtonPress(
    String currentExpression,
    String buttonText,
    CalculatorMode mode, {
    double memoryValue = 0,
    bool useRadians = false,
    bool isSecondFunction = false,
  }) {
    switch (buttonText) {
      case 'C':
      case 'AC':
        return '';
      case 'CE':
        return _clearLastEntry(currentExpression);
      case '=':
        return _evaluateExpression(
          currentExpression,
          mode,
          useRadians: useRadians,
          isSecondFunction: isSecondFunction,
        );
      case '±':
        return _toggleSign(currentExpression, mode, useRadians: useRadians);
      case '%':
        return _handlePercentage(currentExpression, useRadians: useRadians);

      case 'MR':
        return _handleMemoryRecall(currentExpression, memoryValue);

      case 'MC':
      case 'M+':
      case 'M-':
      case '2nd':
        return currentExpression;

      case 'HEX':
      case 'DEC':
      case 'OCT':
      case 'BIN':
        return _handleNumberSystem(
          currentExpression,
          buttonText,
          mode,
          useRadians: useRadians,
        );
      default:
        return _appendToExpression(
          currentExpression, 
          buttonText, 
          mode, 
          isSecondFunction: isSecondFunction
        );
    }
  }

  static String _prepareExpression(
    String expression, {
    bool useRadians = false,
    bool isSecondFunction = false,
  }) {
    String cleanExpression = expression;

    if (cleanExpression.contains('!')) {
      return cleanExpression; 
    }

    cleanExpression = cleanExpression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', 'pi')
        .replaceAll('e', 'e');

    if (!useRadians) {
      final trigFunctions = ['sin', 'cos', 'tan'];
      final inverseTrigFunctions = ['asin', 'acos', 'atan'];
      
      for (var func in trigFunctions) {
        cleanExpression = cleanExpression.replaceAllMapped(
          RegExp('$func\\(([^)]+)\\)'),
          (match) {
            final content = match.group(1)!;
            return '$func(($content * pi / 180))';
          },
        );
      }
      
      for (var func in inverseTrigFunctions) {
        cleanExpression = cleanExpression.replaceAllMapped(
          RegExp('$func\\(([^)]+)\\)'),
          (match) {
            final content = match.group(1)!;
            return '($func($content) * 180 / pi)';
          },
        );
      }
    }

    cleanExpression = cleanExpression
        .replaceAll('√', 'sqrt')
        .replaceAll('log₂', 'log2')
        .replaceAll('ln', 'log')
        .replaceAll('log', 'log10')
        .replaceAll('|x|', 'abs');

    cleanExpression = cleanExpression.replaceAllMapped(
      RegExp(r'(\d+|\))([a-z\(])'),
      (match) => '${match.group(1)}*${match.group(2)}',
    );

    cleanExpression = cleanExpression
        .replaceAll('x²', '^2')
        .replaceAll('x³', '^3')
        .replaceAll('x^y', '^')
        .replaceAll('e^', 'exp');

    return cleanExpression;
  }

  static String _evaluateBasicScientificExpression(
    String expression, {
    bool useRadians = false,
    bool isSecondFunction = false,
  }) {
    if (expression.isEmpty) return '';

    try {
      if (expression.contains('!')) {
        return _handleFactorial(expression);
      }

      if (expression.contains('log2') || expression.contains('cbrt') || expression.contains('mod')) {
        return _handleCustomFunctions(expression, useRadians: useRadians);
      }

      String cleanExpression = _prepareExpression(
        expression,
        useRadians: useRadians,
        isSecondFunction: isSecondFunction,
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
      return 'Error: Calculation error';
    }
  }

  static String _handleCustomFunctions(String expression, {bool useRadians = false}) {
    try {
      if (expression.contains('log2')) {
        var match = RegExp(r'log2\(([^)]+)\)').firstMatch(expression);
        if (match != null) {
          String inner = match.group(1)!;
          double value = double.parse(_evaluateBasicScientificExpression(inner, useRadians: useRadians));
          double result = log(value) / ln2;
          return _formatResult(result);
        }
      }

      if (expression.contains('cbrt')) {
        var match = RegExp(r'cbrt\(([^)]+)\)').firstMatch(expression);
        if (match != null) {
          String inner = match.group(1)!;
          double value = double.parse(_evaluateBasicScientificExpression(inner, useRadians: useRadians));
          double result = pow(value, 1/3).toDouble();
          return _formatResult(result);
        }
      }

      if (expression.contains('mod')) {
        var match = RegExp(r'([^mod]+)mod([^mod]+)').firstMatch(expression);
        if (match != null) {
          String left = match.group(1)!;
          String right = match.group(2)!;
          double leftVal = double.parse(_evaluateBasicScientificExpression(left, useRadians: useRadians));
          double rightVal = double.parse(_evaluateBasicScientificExpression(right, useRadians: useRadians));
          double result = leftVal % rightVal;
          return _formatResult(result);
        }
      }

      return 'Error: Unsupported function';
    } catch (e) {
      return 'Error: Function calculation error';
    }
  }

  static String _handleFactorial(String expression) {
    try {
      var parts = expression.split('!');
      if (parts.length < 2) return 'Error: Invalid factorial';
      String numberStr = parts[0].trim();
      
      if (numberStr.contains(RegExp(r'[+\-*/]'))) {
        numberStr = _evaluateBasicScientificExpression(numberStr);
        if (numberStr.startsWith('Error')) return numberStr;
      }
      
      int n = int.parse(numberStr);
      if (n < 0) return 'Error: Negative factorial';
      if (n > 20) return 'Error: Number too large';
      
      int result = 1;
      for (int i = 2; i <= n; i++) {
        result *= i;
      }
      return result.toString();
    } catch (e) {
      return 'Error: Invalid factorial';
    }
  }

  static String _evaluateProgrammerExpression(String expression) {
    if (expression.isEmpty) return '';

    try {
      String cleanExpression = expression.replaceAll(RegExp(r'[^0-9A-Fa-f+\-*/&|^<>()\s]'), '');
      
      if (!cleanExpression.contains(RegExp(r'[+\-*/&|^<>]'))) {
        return _parseProgrammerNumber(cleanExpression.trim()).toString();
      }
      
      var tokens = _tokenizeProgrammerExpression(cleanExpression);
      if (tokens.isEmpty) return 'Error: Invalid expression';
      
      dynamic result = _parseProgrammerNumber(tokens[0]);
      
      for (int i = 1; i < tokens.length; i += 2) {
        if (i + 1 >= tokens.length) break;
        
        String operator = tokens[i];
        dynamic nextNumber = _parseProgrammerNumber(tokens[i + 1]);
        
        switch (operator) {
          case 'AND': 
          case '&':
            result = (result as int) & (nextNumber as int);
            break;
          case 'OR': 
          case '|':
            result = (result as int) | (nextNumber as int);
            break;
          case 'XOR': 
          case '^':
            result = (result as int) ^ (nextNumber as int);
            break;
          case '<<':
            result = (result as int) << (nextNumber as int);
            break;
          case '>>':
            result = (result as int) >> (nextNumber as int);
            break;
          case 'NOT':
            result = ~(result as int);
            break;
          case '+':
            result = (result as int) + (nextNumber as int);
            break;
          case '-':
            result = (result as int) - (nextNumber as int);
            break;
          case '×':
          case '*':
            result = (result as int) * (nextNumber as int);
            break;
          case '÷':
          case '/':
            if (nextNumber == 0) return 'Error: Division by zero';
            result = (result as int) ~/ (nextNumber as int);
            break;
          default:
            return 'Error: Unknown operator $operator';
        }
      }
      
      return result.toString();
    } catch (e) {
      return 'Error: $e';
    }
  }

  static List<String> _tokenizeProgrammerExpression(String expression) {
    List<String> tokens = [];
    String currentToken = '';
    
    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      
      if (char == ' ') {
        if (currentToken.isNotEmpty) {
          tokens.add(currentToken);
          currentToken = '';
        }
        continue;
      }
      
      if (RegExp(r'[+\-*/&|^<>]').hasMatch(char)) {
        if (currentToken.isNotEmpty) {
          tokens.add(currentToken);
          currentToken = '';
        }
        tokens.add(char);
      } else {
        currentToken += char;
      }
    }
    
    if (currentToken.isNotEmpty) {
      tokens.add(currentToken);
    }
    
    return tokens;
  }

  static int _parseProgrammerNumber(String numberStr) {
    numberStr = numberStr.toUpperCase().trim();
    
    if (numberStr.startsWith('0X')) {
      return int.parse(numberStr.substring(2), radix: 16);
    } else if (numberStr.startsWith('0O')) {
      return int.parse(numberStr.substring(2), radix: 8);
    } else if (numberStr.startsWith('0B')) {
      return int.parse(numberStr.substring(2), radix: 2);
    } else if (RegExp(r'^[A-F]+$').hasMatch(numberStr)) {
      return int.parse(numberStr, radix: 16);
    } else {
      return int.tryParse(numberStr) ?? 0;
    }
  }

  static String _evaluateExpression(
    String expression,
    CalculatorMode mode, {
    bool useRadians = false,
    bool isSecondFunction = false,
  }) {
    if (expression.isEmpty) return '';

    try {
      if (mode == CalculatorMode.programmer) {
        return _evaluateProgrammerExpression(expression);
      } else {
        return _evaluateBasicScientificExpression(
          expression,
          useRadians: useRadians,
          isSecondFunction: isSecondFunction,
        );
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  static String _clearLastEntry(String expression) {
    if (expression.isEmpty) return '';

    for (var op in scientificFunctions) {
      if (expression.endsWith('$op(')) {
        return expression.substring(0, expression.length - (op.length + 1));
      } else if (expression.endsWith(op)) {
        return expression.substring(0, expression.length - op.length);
      }
    }

    return expression.isNotEmpty
        ? expression.substring(0, expression.length - 1)
        : '';
  }

  static String _toggleSign(
    String expression,
    CalculatorMode mode, {
    bool useRadians = false,
  }) {
    if (expression.isEmpty) return '-';

    try {
      String result = _evaluateExpression(
        expression,
        mode,
        useRadians: useRadians,
      );
      if (result.startsWith('Error')) return result;

      if (mode == CalculatorMode.programmer) {
        int value = int.parse(result);
        return (-value).toString();
      } else {
        double value = double.parse(result);
        return _formatResult(-value);
      }
    } catch (e) {
      return 'Error';
    }
  }

  static String _handlePercentage(
    String expression, {
    bool useRadians = false,
  }) {
    if (expression.isEmpty) return '';

    try {
      String result = _evaluateExpression(
        expression,
        CalculatorMode.basic,
        useRadians: useRadians,
      );
      if (result.startsWith('Error')) return result;

      double value = double.parse(result);
      return _formatResult(value / 100);
    } catch (e) {
      return 'Error';
    }
  }

  static String _handleMemoryRecall(String expression, double memoryValue) {
    final memStr = _formatResult(memoryValue);
    if (expression.isEmpty ||
        isOperator(expression.substring(expression.length - 1))) {
      return expression + memStr;
    }
    return '$expression×$memStr';
  }

  static String _handleNumberSystem(
    String currentExpression,
    String system,
    CalculatorMode mode, {
    bool useRadians = false,
  }) {
    if (currentExpression.isEmpty) return currentExpression;

    try {
      String result = _evaluateExpression(
        currentExpression,
        CalculatorMode.programmer,
        useRadians: useRadians,
      );
      if (result.startsWith('Error')) return result;

      int value = int.tryParse(result) ?? 0;

      switch (system) {
        case 'HEX':
          return '0x${value.toRadixString(16).toUpperCase()}';
        case 'DEC':
          return value.toString();
        case 'OCT':
          return '0o${value.toRadixString(8)}';
        case 'BIN':
          return '0b${value.toRadixString(2)}';
        default:
          return result;
      }
    } catch (e) {
      return 'Error';
    }
  }

  static String _appendToExpression(
    String currentExpression,
    String buttonText,
    CalculatorMode mode, {
    bool isSecondFunction = false,
  }) {
    if (scientificFunctions.contains(buttonText)) {
      return '$currentExpression$buttonText(';
    }

    if (buttonText == 'x²' || buttonText == 'x³' || buttonText == 'x^y') {
      if (currentExpression.isEmpty) return currentExpression + buttonText;
      if (buttonText == 'x^y') {
        return '$currentExpression^';
      }
      return '$currentExpression${buttonText.substring(1)}';
    }

    if (mode == CalculatorMode.programmer &&
        programmerOperations.contains(buttonText)) {
      return '$currentExpression$buttonText';
    }

    return currentExpression + buttonText;
  }

  static String _formatResult(double result) {
    if (result == result.truncateToDouble()) {
      return result.truncate().toString();
    } else {
      String formatted = result.toStringAsFixed(10);
      formatted = formatted.replaceAll(RegExp(r'0+$'), '');
      formatted = formatted.replaceAll(RegExp(r'\.$'), '');
      return formatted;
    }
  }

  static bool isOperator(String text) {
    return basicOperations.contains(text) ||
        scientificFunctions.contains(text) ||
        programmerOperations.contains(text);
  }
}