import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CalculatorButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOperator;
  final bool isSpecial;
  final double? width;
  final double? height;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOperator = false,
    this.isSpecial = false,
    this.width,
    this.height,
  });

  @override
  _CalculatorButtonState createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppDimensions.buttonPressDuration,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    Color getButtonColor() {
      if (widget.isSpecial) {
        return Colors.red;
      }
      if (widget.isOperator) {
        return isDark ? AppColors.darkAccent : AppColors.lightAccent;
      }
      return isDark ? AppColors.darkSurface : AppColors.lightSurface;
    }

    Color getTextColor() {
      if (widget.isSpecial || widget.isOperator) {
        return Colors.white;
      }
      return isDark ? Colors.white : AppColors.lightPrimary;
    }

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: widget.width ?? 70,
          height: widget.height ?? 70,
          margin: const EdgeInsets.all(AppDimensions.buttonSpacing / 2),
          decoration: BoxDecoration(
            color: getButtonColor(),
            borderRadius: BorderRadius.circular(AppDimensions.buttonBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: AppTextStyles.buttonText.copyWith(
                color: getTextColor(),
                fontWeight: widget.isOperator || widget.isSpecial 
                    ? FontWeight.w600 
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}