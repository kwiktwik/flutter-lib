import 'package:flutter/material.dart';

class KwikSearchBar extends StatelessWidget {
  final String hint;
  const KwikSearchBar({super.key, required this.hint});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(Icons.search, color: theme.primaryColor),
        fillColor: theme.cardColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
        ),
      ),
      style: theme.textTheme.bodyMedium,
    );
  }
}