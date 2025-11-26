import 'package:flutter/material.dart';
import 'calculator_button.dart';
import '../models/calculator_mode.dart';

class ButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;
  final CalculatorMode currentMode;
  final bool isSecondFunction;

  const ButtonGrid({
    super.key,
    required this.onButtonPressed,
    required this.currentMode,
    required this.isSecondFunction,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentMode) {
      case CalculatorMode.basic:
        return _buildBasicGrid();
      case CalculatorMode.scientific:
        return _buildScientificGrid();
      case CalculatorMode.programmer:
        return _buildProgrammerGrid();
    }
  }

  Widget _buildBasicGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 1.2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: [
        CalculatorButton(
          text: 'C',
          onPressed: () => onButtonPressed('C'),
          isSpecial: true,
        ),
        CalculatorButton(
          text: 'CE',
          onPressed: () => onButtonPressed('CE'),
          isSpecial: true,
        ),
        CalculatorButton(
          text: '%',
          onPressed: () => onButtonPressed('%'),
          isOperator: true,
        ),
        CalculatorButton(
          text: '÷',
          onPressed: () => onButtonPressed('÷'),
          isOperator: true,
        ),
        CalculatorButton(text: '7', onPressed: () => onButtonPressed('7')),
        CalculatorButton(text: '8', onPressed: () => onButtonPressed('8')),
        CalculatorButton(text: '9', onPressed: () => onButtonPressed('9')),
        CalculatorButton(
          text: '×',
          onPressed: () => onButtonPressed('×'),
          isOperator: true,
        ),
        CalculatorButton(text: '4', onPressed: () => onButtonPressed('4')),
        CalculatorButton(text: '5', onPressed: () => onButtonPressed('5')),
        CalculatorButton(text: '6', onPressed: () => onButtonPressed('6')),
        CalculatorButton(
          text: '-',
          onPressed: () => onButtonPressed('-'),
          isOperator: true,
        ),
        CalculatorButton(text: '1', onPressed: () => onButtonPressed('1')),
        CalculatorButton(text: '2', onPressed: () => onButtonPressed('2')),
        CalculatorButton(text: '3', onPressed: () => onButtonPressed('3')),
        CalculatorButton(
          text: '+',
          onPressed: () => onButtonPressed('+'),
          isOperator: true,
        ),
        CalculatorButton(
          text: '±',
          onPressed: () => onButtonPressed('±'),
          isOperator: true,
        ),
        CalculatorButton(text: '0', onPressed: () => onButtonPressed('0')),
        CalculatorButton(text: '.', onPressed: () => onButtonPressed('.')),
        CalculatorButton(
          text: '=',
          onPressed: () => onButtonPressed('='),
          isOperator: true,
        ),
      ],
    );
  }

  Widget _buildScientificGrid() {
    List<String> firstRow = isSecondFunction
        ? ['asin', 'acos', 'atan', 'log₂', 'e^', '10^']
        : ['sin', 'cos', 'tan', 'ln', 'log', 'x^y'];

    List<String> secondRow = isSecondFunction
        ? ['x³', '∛', '|x|', 'n!', 'mod', '÷']
        : ['x²', '√', '(', ')', 'π', '÷'];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 6,
      childAspectRatio: 1.0,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      padding: const EdgeInsets.all(8),
      children: [
        ...firstRow.map(
          (text) => CalculatorButton(
            text: text,
            onPressed: () => onButtonPressed(text),
            isOperator: true,
          ),
        ),
        ...secondRow.map(
          (text) => CalculatorButton(
            text: text,
            onPressed: () => onButtonPressed(text),
            isOperator: text == '÷' || text == 'mod',
          ),
        ),
        CalculatorButton(
          text: 'MC',
          onPressed: () => onButtonPressed('MC'),
          isOperator: true,
        ),
        CalculatorButton(text: '7', onPressed: () => onButtonPressed('7')),
        CalculatorButton(text: '8', onPressed: () => onButtonPressed('8')),
        CalculatorButton(text: '9', onPressed: () => onButtonPressed('9')),
        CalculatorButton(
          text: 'C',
          onPressed: () => onButtonPressed('C'),
          isSpecial: true,
        ),
        CalculatorButton(
          text: '×',
          onPressed: () => onButtonPressed('×'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'MR',
          onPressed: () => onButtonPressed('MR'),
          isOperator: true,
        ),
        CalculatorButton(text: '4', onPressed: () => onButtonPressed('4')),
        CalculatorButton(text: '5', onPressed: () => onButtonPressed('5')),
        CalculatorButton(text: '6', onPressed: () => onButtonPressed('6')),
        CalculatorButton(
          text: 'CE',
          onPressed: () => onButtonPressed('CE'),
          isSpecial: true,
        ),
        CalculatorButton(
          text: '-',
          onPressed: () => onButtonPressed('-'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'M+',
          onPressed: () => onButtonPressed('M+'),
          isOperator: true,
        ),
        CalculatorButton(text: '1', onPressed: () => onButtonPressed('1')),
        CalculatorButton(text: '2', onPressed: () => onButtonPressed('2')),
        CalculatorButton(text: '3', onPressed: () => onButtonPressed('3')),
        CalculatorButton(
          text: '%',
          onPressed: () => onButtonPressed('%'),
          isOperator: true,
        ),
        CalculatorButton(
          text: '+',
          onPressed: () => onButtonPressed('+'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'M-',
          onPressed: () => onButtonPressed('M-'),
          isOperator: true,
        ),
        CalculatorButton(
          text: '±',
          onPressed: () => onButtonPressed('±'),
          isOperator: true,
        ),
        CalculatorButton(text: '0', onPressed: () => onButtonPressed('0')),
        CalculatorButton(text: '.', onPressed: () => onButtonPressed('.')),
        CalculatorButton(
          text: 'π',
          onPressed: () => onButtonPressed('π'),
          isOperator: true,
        ),
        CalculatorButton(
          text: '=',
          onPressed: () => onButtonPressed('='),
          isOperator: true,
        ),
      ],
    );
  }

  Widget _buildProgrammerGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 1.5,
      mainAxisSpacing: 1,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: [
        CalculatorButton(
          text: 'HEX',
          onPressed: () => onButtonPressed('HEX'),
          isSpecial: true,
        ),
        CalculatorButton(
          text: 'DEC',
          onPressed: () => onButtonPressed('DEC'),
          isSpecial: true,
        ),
        CalculatorButton(
          text: 'OCT',
          onPressed: () => onButtonPressed('OCT'),
          isSpecial: true,
        ),
        CalculatorButton(
          text: 'BIN',
          onPressed: () => onButtonPressed('BIN'),
          isSpecial: true,
        ),
        CalculatorButton(
          text: 'A',
          onPressed: () => onButtonPressed('A'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'B',
          onPressed: () => onButtonPressed('B'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'C',
          onPressed: () => onButtonPressed('C'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'D',
          onPressed: () => onButtonPressed('D'),
          isOperator: true,
        ),

        CalculatorButton(
          text: 'E',
          onPressed: () => onButtonPressed('E'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'F',
          onPressed: () => onButtonPressed('F'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'AND',
          onPressed: () => onButtonPressed('AND'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'OR',
          onPressed: () => onButtonPressed('OR'),
          isOperator: true,
        ),

        CalculatorButton(
          text: 'NOT',
          onPressed: () => onButtonPressed('NOT'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'XOR',
          onPressed: () => onButtonPressed('XOR'),
          isOperator: true,
        ),
        CalculatorButton(
          text: '<<',
          onPressed: () => onButtonPressed('<<'),
          isOperator: true,
        ),
        CalculatorButton(
          text: '>>',
          onPressed: () => onButtonPressed('>>'),
          isOperator: true,
        ),

        CalculatorButton(text: '7', onPressed: () => onButtonPressed('7')),
        CalculatorButton(text: '8', onPressed: () => onButtonPressed('8')),
        CalculatorButton(text: '9', onPressed: () => onButtonPressed('9')),
        CalculatorButton(
          text: 'C',
          onPressed: () => onButtonPressed('C'),
          isSpecial: true,
        ),

        CalculatorButton(text: '4', onPressed: () => onButtonPressed('4')),
        CalculatorButton(text: '5', onPressed: () => onButtonPressed('5')),
        CalculatorButton(text: '6', onPressed: () => onButtonPressed('6')),
        CalculatorButton(
          text: '÷',
          onPressed: () => onButtonPressed('÷'),
          isOperator: true,
        ),

        CalculatorButton(text: '1', onPressed: () => onButtonPressed('1')),
        CalculatorButton(text: '2', onPressed: () => onButtonPressed('2')),
        CalculatorButton(text: '3', onPressed: () => onButtonPressed('3')),
        CalculatorButton(
          text: '×',
          onPressed: () => onButtonPressed('×'),
          isOperator: true,
        ),

        CalculatorButton(text: '0', onPressed: () => onButtonPressed('0')),
        CalculatorButton(
          text: '±',
          onPressed: () => onButtonPressed('±'),
          isOperator: true,
        ),
        CalculatorButton(
          text: 'CE',
          onPressed: () => onButtonPressed('CE'),
          isSpecial: true,
        ),
        CalculatorButton(
          text: '=',
          onPressed: () => onButtonPressed('='),
          isOperator: true,
        ),
      ],
    );
  }
}
