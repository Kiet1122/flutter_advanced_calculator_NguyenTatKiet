import 'package:flutter/material.dart';
import '../utils/constants.dart';

class DisplayArea extends StatelessWidget {
  final String currentExpression;
  final String previousResult;
  final bool isRadiansMode;
  final bool hasMemory;
  final VoidCallback onClear;
  final VoidCallback onDeleteLast;

  const DisplayArea({
    super.key,
    required this.currentExpression,
    required this.previousResult,
    required this.isRadiansMode,
    required this.hasMemory,
    required this.onClear,
    required this.onDeleteLast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.screenPadding),
      margin: const EdgeInsets.all(AppDimensions.screenPadding),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppDimensions.displayBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (hasMemory)
                Row(
                  children: [
                    Icon(
                      Icons.memory,
                      size: 16,
                      color: isDark ? AppColors.darkAccent : AppColors.lightAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'M',
                      style: AppTextStyles.historyText.copyWith(
                        color: isDark ? AppColors.darkAccent : AppColors.lightAccent,
                      ),
                    ),
                  ],
                ),
              Text(
                isRadiansMode ? 'RAD' : 'DEG',
                style: AppTextStyles.historyText.copyWith(
                  color: isDark ? AppColors.darkAccent : AppColors.lightAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (previousResult.isNotEmpty)
            Text(
              '= $previousResult',
              style: AppTextStyles.historyText.copyWith(
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              currentExpression.isEmpty ? '0' : currentExpression,
              style: AppTextStyles.displayText.copyWith(
                color: isDark ? Colors.white : AppColors.lightPrimary,
              ),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Press C to clear • CE to delete last',
            style: AppTextStyles.historyText.copyWith(
              fontSize: 12,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}