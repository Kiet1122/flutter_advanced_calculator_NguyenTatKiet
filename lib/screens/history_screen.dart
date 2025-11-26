import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculation_history.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    final calculatorProvider = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        actions: [
          if (historyProvider.history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showClearHistoryDialog(context, historyProvider);
              },
            ),
        ],
      ),
      body: historyProvider.history.isEmpty
          ? const Center(
              child: Text(
                'No calculation history',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: historyProvider.history.length,
              itemBuilder: (context, index) {
                final calculation = historyProvider.history[index];
                return _HistoryItem(
                  calculation: calculation,
                  onTap: () {
                    calculatorProvider.setExpression(calculation.expression);
                    Navigator.pop(context);
                  },
                  onDelete: () {
                    historyProvider.removeCalculation(calculation);
                  },
                );
              },
            ),
    );
  }

  void _showClearHistoryDialog(BuildContext context, HistoryProvider historyProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to clear all calculation history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              historyProvider.clearHistory();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final CalculationHistory calculation;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _HistoryItem({
    required this.calculation,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(calculation.timestamp.millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDelete(),
      child: ListTile(
        title: Text(
          calculation.expression,
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          '= ${calculation.result}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          calculation.mode.name,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}