class CalculatorSettings {
  final bool isDarkMode;
  final int decimalPrecision;
  final bool useRadians;
  final bool hapticFeedback;
  final int historySize;
  
  const CalculatorSettings({
    this.isDarkMode = false,
    this.decimalPrecision = 6,
    this.useRadians = false,
    this.hapticFeedback = true,
    this.historySize = 50,
  });
  
  CalculatorSettings copyWith({
    bool? isDarkMode,
    int? decimalPrecision,
    bool? useRadians,
    bool? hapticFeedback,
    int? historySize,
  }) {
    return CalculatorSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      decimalPrecision: decimalPrecision ?? this.decimalPrecision,
      useRadians: useRadians ?? this.useRadians,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      historySize: historySize ?? this.historySize,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'decimalPrecision': decimalPrecision,
      'useRadians': useRadians,
      'hapticFeedback': hapticFeedback,
      'historySize': historySize,
    };
  }
  
  factory CalculatorSettings.fromJson(Map<String, dynamic> json) {
    return CalculatorSettings(
      isDarkMode: json['isDarkMode'] ?? false,
      decimalPrecision: json['decimalPrecision'] ?? 6,
      useRadians: json['useRadians'] ?? false,
      hapticFeedback: json['hapticFeedback'] ?? true,
      historySize: json['historySize'] ?? 50,
    );
  }
}