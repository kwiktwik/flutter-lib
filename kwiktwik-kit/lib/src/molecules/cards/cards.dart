import 'package:flutter/material.dart';

class KwikCard extends StatelessWidget {
  final Widget child;
  const KwikCard({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.cardColor,
      child: DefaultTextStyle(
        style: theme.textTheme.bodyMedium!,
        child: child,
      ),
    );
  }
}