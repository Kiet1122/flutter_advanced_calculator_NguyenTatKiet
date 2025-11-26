import 'package:flutter/material.dart';
import '../models/calculator_mode.dart';
import '../utils/constants.dart';

class ModeSelector extends StatefulWidget {
  final CalculatorMode currentMode;
  final Function(CalculatorMode) onModeChanged;
  final bool isSecondFunction;
  final VoidCallback onSecondFunctionToggled;

  const ModeSelector({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
    required this.isSecondFunction,
    required this.onSecondFunctionToggled,
  });

  @override
  _ModeSelectorState createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<ModeSelector> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.screenPadding),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppDimensions.buttonBorderRadius),
      ),
      child: Row(
        children: [
          if (widget.currentMode == CalculatorMode.scientific)
            GestureDetector(
              onTap: widget.onSecondFunctionToggled,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: widget.isSecondFunction 
                      ? (isDark ? AppColors.darkAccent : AppColors.lightAccent)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? AppColors.darkAccent : AppColors.lightAccent,
                  ),
                ),
                child: Text(
                  '2nd',
                  style: AppTextStyles.modeText.copyWith(
                    color: widget.isSecondFunction 
                        ? Colors.white 
                        : (isDark ? AppColors.darkAccent : AppColors.lightAccent),
                  ),
                ),
              ),
            ),
          if (widget.currentMode == CalculatorMode.scientific) 
            const SizedBox(width: 12),
          Expanded(
            child: SegmentedButton<CalculatorMode>(
              segments: const [
                ButtonSegment<CalculatorMode>(
                  value: CalculatorMode.basic,
                  label: Text('Basic'),
                ),
                ButtonSegment<CalculatorMode>(
                  value: CalculatorMode.scientific,
                  label: Text('Scientific'),
                ),
                ButtonSegment<CalculatorMode>(
                  value: CalculatorMode.programmer,
                  label: Text('Programmer'),
                ),
              ],
              selected: {widget.currentMode},
              onSelectionChanged: (Set<CalculatorMode> newSelection) {
                widget.onModeChanged(newSelection.first);
              },
            ),
          ),
        ],
      ),
    );
  }
}