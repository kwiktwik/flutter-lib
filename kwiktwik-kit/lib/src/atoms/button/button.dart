import 'package:flutter/material.dart';

class KwikButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const KwikButton({super.key, required this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryColor,
      ),
      child: Text(text, style: theme.textTheme.bodyMedium),
    );
  }
}