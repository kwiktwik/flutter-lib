import 'package:flutter/material.dart';

class KwikBottomNav extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const KwikBottomNav({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      selectedItemColor: selectedItemColor ?? theme.primaryColor,
      unselectedItemColor: unselectedItemColor ?? theme.textTheme.bodySmall?.color,
      items: items,
    );
  }
}