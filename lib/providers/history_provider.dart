import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../services/storage_service.dart';

class HistoryProvider with ChangeNotifier {
  final List<CalculationHistory> _history = [];
  final StorageService _storageService = StorageService();
  
  List<CalculationHistory> get history => _history;
  int get historyCount => _history.length;
  
  HistoryProvider() {
    _loadHistory();
  }
  
  Future<void> _loadHistory() async {
    _history.clear();
    _history.addAll(await _storageService.loadHistory());
    notifyListeners();
  }
  
  Future<void> addCalculation(CalculationHistory calculation) async {
    _history.insert(0, calculation);
    
    if (_history.length > 50) {
      _history.removeLast();
    }
    
    await _storageService.saveHistory(_history);
    notifyListeners();
  }
  
  Future<void> clearHistory() async {
    _history.clear();
    await _storageService.saveHistory(_history);
    notifyListeners();
  }
  
  Future<void> removeCalculation(CalculationHistory calculation) async {
    _history.remove(calculation);
    await _storageService.saveHistory(_history);
    notifyListeners();
  }
  
  List<CalculationHistory> getRecentCalculations(int count) {
    if (_history.length <= count) {
      return _history;
    }
    return _history.sublist(0, count);
  }
}