import 'package:flutter/material.dart';
import 'package:kwiktwik_kit/kwiktwik_kit.dart';

class UiElementsPage extends StatelessWidget {
  const UiElementsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('UI Elements')),
      body: KwikSafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Search Bar', style: theme.textTheme.bodyMedium),
              const KwikSearchBar(hint: 'Search items...'),
              const SizedBox(height: 20),
              Text('Select Box / Dropdown', style: theme.textTheme.bodyMedium),
              DropdownButton<String>(
                value: 'Option 1',
                items: const [
                  DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                  DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
                ],
                onChanged: (_) {},
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Text('Bottom Sheet', style: theme.textTheme.bodyMedium),
              ElevatedButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (ctx) => Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Bottom Sheet Content', style: theme.textTheme.bodyMedium),
                        KwikButton(text: 'Close', onPressed: null),
                      ],
                    ),
                  ),
                ),
                child: const Text('Show Bottom Sheet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}