import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';
import '../models/calculator_settings.dart';

class StorageService {
  static const String _historyKey = 'calculation_history';
  static const String _settingsKey = 'calculator_settings';
  static const String _memoryKey = 'memory_value';
  
  Future<void> saveHistory(List<CalculationHistory> history) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = history.map((h) => h.toJson()).toList();
    await prefs.setString(_historyKey, jsonEncode(historyJson));
  }
  
  Future<List<CalculationHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_historyKey);
    
    if (historyJson != null) {
      try {
        final List<dynamic> historyList = jsonDecode(historyJson);
        return historyList.map((json) => CalculationHistory.fromJson(json)).toList();
      } catch (e) {
        return [];
      }
    }
    
    return [];
  }
  
  Future<void> saveSettings(CalculatorSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, jsonEncode(settings.toJson()));
  }
  
  Future<CalculatorSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString(_settingsKey);
    
    if (settingsJson != null) {
      try {
        final Map<String, dynamic> settingsMap = jsonDecode(settingsJson);
        return CalculatorSettings.fromJson(settingsMap);
      } catch (e) {
        return const CalculatorSettings();
      }
    }
    
    return const CalculatorSettings();
  }
  
  Future<void> saveMemoryValue(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_memoryKey, value);
  }
  
  Future<double> loadMemoryValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_memoryKey) ?? 0.0;
  }
  
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
    await prefs.remove(_memoryKey);
  }
}