enum CalculatorMode {
  basic,
  scientific,
  programmer,
}

extension CalculatorModeExtension on CalculatorMode {
  String get name {
    switch (this) {
      case CalculatorMode.basic:
        return 'Basic';
      case CalculatorMode.scientific:
        return 'Scientific';
      case CalculatorMode.programmer:
        return 'Programmer';
    }
  }
  
  String get description {
    switch (this) {
      case CalculatorMode.basic:
        return 'Basic arithmetic operations';
      case CalculatorMode.scientific:
        return 'Advanced mathematical functions';
      case CalculatorMode.programmer:
        return 'Bitwise operations and number systems';
    }
  }
}