import 'package:advanced_calculator/models/calculator_mode.dart';

class CalculationHistory {
  final String expression;
  final String result;
  final DateTime timestamp;
  final CalculatorMode mode;
  
  const CalculationHistory({
    required this.expression,
    required this.result,
    required this.timestamp,
    required this.mode,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'result': result,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'mode': mode.index,
    };
  }
  
  factory CalculationHistory.fromJson(Map<String, dynamic> json) {
    return CalculationHistory(
      expression: json['expression'],
      result: json['result'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      mode: CalculatorMode.values[json['mode']],
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CalculationHistory &&
        other.expression == expression &&
        other.result == result &&
        other.timestamp == timestamp &&
        other.mode == mode;
  }
  
  @override
  int get hashCode {
    return Object.hash(expression, result, timestamp, mode);
  }
}