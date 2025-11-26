import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/history_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsSection(
            title: 'Appearance',
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: themeProvider.settings.isDarkMode,
                onChanged: (value) {
                  themeProvider.updateSettings(
                    themeProvider.settings.copyWith(isDarkMode: value),
                  );
                },
              ),
            ],
          ),
          _SettingsSection(
            title: 'Calculation',
            children: [
              SwitchListTile(
                title: const Text('Use Radians'),
                subtitle: const Text('Use radians instead of degrees for trigonometric functions'),
                value: themeProvider.settings.useRadians,
                onChanged: (value) {
                  themeProvider.updateSettings(
                    themeProvider.settings.copyWith(useRadians: value),
                  );
                },
              ),
              ListTile(
                title: const Text('Decimal Precision'),
                subtitle: Text('${themeProvider.settings.decimalPrecision} decimal places'),
                trailing: DropdownButton<int>(
                  value: themeProvider.settings.decimalPrecision,
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.updateSettings(
                        themeProvider.settings.copyWith(decimalPrecision: value),
                      );
                    }
                  },
                  items: [2, 4, 6, 8, 10]
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text('$value'),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          _SettingsSection(
            title: 'History',
            children: [
              ListTile(
                title: const Text('History Size'),
                subtitle: Text('${themeProvider.settings.historySize} calculations'),
                trailing: DropdownButton<int>(
                  value: themeProvider.settings.historySize,
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.updateSettings(
                        themeProvider.settings.copyWith(historySize: value),
                      );
                    }
                  },
                  items: [25, 50, 100]
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text('$value'),
                          ))
                      .toList(),
                ),
              ),
              ListTile(
                title: const Text('Clear All History'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showClearHistoryDialog(context, historyProvider);
                  },
                ),
              ),
            ],
          ),
          _SettingsSection(
            title: 'Other',
            children: [
              SwitchListTile(
                title: const Text('Haptic Feedback'),
                value: themeProvider.settings.hapticFeedback,
                onChanged: (value) {
                  themeProvider.updateSettings(
                    themeProvider.settings.copyWith(hapticFeedback: value),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context, HistoryProvider historyProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All History'),
        content: const Text('This action cannot be undone. Are you sure you want to clear all calculation history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              historyProvider.clearHistory();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('History cleared')),
              );
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}