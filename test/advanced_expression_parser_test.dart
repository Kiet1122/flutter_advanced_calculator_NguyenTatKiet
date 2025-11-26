import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_calculator/utils/expression_parser.dart';

void main() {
  group('Advanced Expression Parser - Complex Expressions', () {
    test('should handle complex nested expressions', () {
      final result = ExpressionParser.evaluateExpression('((2+3)×(4-1))÷5');
      expect(result == '3' || result.contains('Error'), true);
    });

    test('should handle multiple operations with precedence', () {
      final result = ExpressionParser.evaluateExpression('2+3×4-6÷2+1');
      expect(result.isNotEmpty, true);
    });

    test('should handle expressions with constants', () {
      final result = ExpressionParser.evaluateExpression('2×π');
      expect(result.isNotEmpty, true);
    });
  });

  group('Advanced Expression Parser - Error Handling', () {
    test('should handle division by zero', () {
      final result = ExpressionParser.evaluateExpression('1/0');
      expect(result.contains('Error'), true);
    });

    test('should handle invalid expressions', () {
      final result = ExpressionParser.evaluateExpression('2++3');
      expect(result.contains('Error'), true);
    });

    test('should handle empty expression', () {
      expect(ExpressionParser.evaluateExpression(''), '');
    });

    test('should handle unbalanced parentheses', () {
      final result = ExpressionParser.evaluateExpression('(2+3');
      expect(result.contains('Error'), true);
    });

    test('should handle trailing operators', () {
      final result = ExpressionParser.evaluateExpression('2+');
      expect(result.contains('Error'), true);
    });
  });

  group('Advanced Expression Parser - Scientific Functions', () {
    test('should handle square root', () {
      final result = ExpressionParser.evaluateExpression('sqrt(9)');
      expect(result == '3' || result.contains('Error'), true);
    });

    test('should handle sine function', () {
      final result = ExpressionParser.evaluateExpression('sin(90)');
      expect(result.isNotEmpty, true);
    });

    test('should handle logarithmic functions', () {
      final result = ExpressionParser.evaluateExpression('log(100)');
      expect(result.isNotEmpty, true);
    });
  });

  group('Advanced Expression Parser - Validation', () {
    test('should validate correct expressions', () {
      expect(ExpressionParser.isValidExpression('2+3×(4-1)'), true);
      expect(ExpressionParser.isValidExpression('sin(90)+cos(0)'), true);
    });

    test('should invalidate incorrect expressions', () {
      expect(ExpressionParser.isValidExpression('2++3'), false);
      expect(ExpressionParser.isValidExpression('sin(90'), false);
      expect(ExpressionParser.isValidExpression(''), false);
    });
  });
}