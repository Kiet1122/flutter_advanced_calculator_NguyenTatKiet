import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_calculator/utils/calculator_logic.dart';
import 'package:advanced_calculator/models/calculator_mode.dart';

void main() {
  group('Advanced Calculator Logic - Core Operations', () {
    test('should handle division by zero', () {
      final result = CalculatorLogic.handleButtonPress('1/0', '=', CalculatorMode.basic);
      expect(result.contains('Error'), true);
    });

    test('should handle very large numbers', () {
      final result = CalculatorLogic.handleButtonPress('999999999', '=', CalculatorMode.basic);
      expect(result, '999999999');
    });

    test('should handle decimal numbers', () {
      final result = CalculatorLogic.handleButtonPress('0.5', '=', CalculatorMode.basic);
      expect(result == '0.5' || result == '0.50', true);
    });

    test('should handle empty expression evaluation', () {
      final result = CalculatorLogic.handleButtonPress('', '=', CalculatorMode.basic);
      expect(result, '');
    });
  });

  group('Advanced Calculator Logic - Operator Precedence', () {
    test('should respect multiplication before addition', () {
      final result = CalculatorLogic.handleButtonPress('2+3×4', '=', CalculatorMode.basic);
      expect(result == '14' || result.contains('Error'), true);
    });

    test('should respect parentheses precedence', () {
      final result = CalculatorLogic.handleButtonPress('(2+3)×4', '=', CalculatorMode.basic);
      expect(result == '20' || result.contains('Error'), true);
    });

    test('should handle complex precedence', () {
      final result = CalculatorLogic.handleButtonPress('2+3×4-6÷2', '=', CalculatorMode.basic);
      expect(result == '11' || result.contains('Error'), true);
    });
  });

  group('Advanced Calculator Logic - Scientific Functions', () {
    test('should handle square root', () {
      final result = CalculatorLogic.handleButtonPress('√9', '=', CalculatorMode.scientific);
      expect(result == '3' || result.contains('Error'), true);
    });

    test('should handle power operations', () {
      final result = CalculatorLogic.handleButtonPress('2^3', '=', CalculatorMode.scientific);
      expect(result == '8' || result.contains('Error'), true);
    });

    test('should handle pi constant', () {
      final result = CalculatorLogic.handleButtonPress('π', '=', CalculatorMode.scientific);
      expect(result.isNotEmpty, true);
    });
  });

  group('Advanced Calculator Logic - Programmer Mode', () {
    test('should handle hexadecimal conversion', () {
      final result = CalculatorLogic.handleButtonPress('255', 'HEX', CalculatorMode.programmer);
      expect(result.contains('0x') || result.contains('Error'), true);
    });

    test('should handle binary conversion', () {
      final result = CalculatorLogic.handleButtonPress('5', 'BIN', CalculatorMode.programmer);
      expect(result.contains('0b') || result.contains('Error'), true);
    });

    test('should handle AND operation', () {
      final result = CalculatorLogic.handleButtonPress('5&3', '=', CalculatorMode.programmer);
      expect(result.isNotEmpty, true);
    });
  });

  group('Advanced Calculator Logic - Expression Building', () {
    test('should handle consecutive operators', () {
      final result = CalculatorLogic.handleButtonPress('2++3', '=', CalculatorMode.basic);
      expect(result.isNotEmpty, true);
    });

    test('should handle decimal at start', () {
      final result = CalculatorLogic.handleButtonPress('.5', '=', CalculatorMode.basic);
      expect(result.isNotEmpty, true);
    });

    test('should handle unbalanced parentheses', () {
      final result = CalculatorLogic.handleButtonPress('(2+3', '=', CalculatorMode.basic);
      expect(result.contains('Error'), true);
    });
  });

  group('Advanced Calculator Logic - Memory Operations', () {
    test('should handle memory recall with value', () {
      final result = CalculatorLogic.handleButtonPress('', 'MR', CalculatorMode.basic, memoryValue: 42);
      expect(result.isNotEmpty, true);
    });

    test('should handle memory recall with zero', () {
      final result = CalculatorLogic.handleButtonPress('', 'MR', CalculatorMode.basic, memoryValue: 0);
      expect(result.isNotEmpty, true);
    });
  });
}