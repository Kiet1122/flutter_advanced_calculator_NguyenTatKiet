import 'package:advanced_calculator/services/storage_service.dart';
import 'package:flutter/material.dart';
import '../models/calculator_settings.dart';
import '../utils/constants.dart';

class ThemeProvider with ChangeNotifier {
  CalculatorSettings _settings = const CalculatorSettings();
  final StorageService _storageService = StorageService();
  
  CalculatorSettings get settings => _settings;
  
  ThemeProvider() {
    _loadSettings();
  }
  
  Future<void> _loadSettings() async {
    _settings = await _storageService.loadSettings();
    notifyListeners();
  }
  
  Future<void> updateSettings(CalculatorSettings newSettings) async {
    _settings = newSettings;
    await _storageService.saveSettings(newSettings);
    notifyListeners();
  }
  
  Future<void> toggleTheme() async {
    _settings = _settings.copyWith(isDarkMode: !_settings.isDarkMode);
    await _storageService.saveSettings(_settings);
    notifyListeners();
  }
  
  Future<void> setAngleMode(bool useRadians) async {
    _settings = _settings.copyWith(useRadians: useRadians);
    await _storageService.saveSettings(_settings);
    notifyListeners();
  }
  
  Future<void> setDecimalPrecision(int precision) async {
    _settings = _settings.copyWith(decimalPrecision: precision);
    await _storageService.saveSettings(_settings);
    notifyListeners();
  }
  
  ThemeData get currentTheme {
    return _settings.isDarkMode ? _darkTheme : _lightTheme;
  }
  
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightAccent,
      background: AppColors.lightBackground,
      surface: AppColors.lightSurface,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightSurface,
    textTheme: const TextTheme(
      bodyLarge: AppTextStyles.displayText,
      bodyMedium: AppTextStyles.buttonText,
      bodySmall: AppTextStyles.historyText,
    ),
  );
  
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkAccent,
      background: AppColors.darkBackground,
      surface: AppColors.darkSurface,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkSurface,
    textTheme: TextTheme(
      bodyLarge: AppTextStyles.displayText.copyWith(color: Colors.white),
      bodyMedium: AppTextStyles.buttonText.copyWith(color: Colors.white),
      bodySmall: AppTextStyles.historyText.copyWith(color: Colors.white70),
    ),
  );
}