import 'package:flutter/material.dart';

class AppColors {
  static const Color lightPrimary = Color(0xFF1E1E1E);
  static const Color lightSecondary = Color(0xFF424242);
  static const Color lightAccent = Color(0xFFFF6B6B);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  
  static const Color darkPrimary = Color(0xFF121212);
  static const Color darkSecondary = Color(0xFF2C2C2C);
  static const Color darkAccent = Color(0xFF4ECDC4);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF00C853);
}

class AppTextStyles {
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
  );
  
  static const TextStyle displayText = TextStyle(
    fontSize: 32,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );
  
  static const TextStyle historyText = TextStyle(
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
  );
  
  static const TextStyle modeText = TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );
}

class AppDimensions {
  static const double buttonSpacing = 12.0;
  static const double screenPadding = 24.0;
  static const double buttonBorderRadius = 16.0;
  static const double displayBorderRadius = 24.0;
  
  static const Duration buttonPressDuration = Duration(milliseconds: 200);
  static const Duration modeSwitchDuration = Duration(milliseconds: 300);
}