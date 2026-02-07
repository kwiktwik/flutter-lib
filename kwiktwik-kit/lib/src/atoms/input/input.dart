import 'package:flutter/material.dart';

class KwikInput extends StatelessWidget {
  final String hint;
  const KwikInput({super.key, required this.hint});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        fillColor: theme.cardColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
        ),
      ),
      style: theme.textTheme.bodyMedium,
    );
  }
}