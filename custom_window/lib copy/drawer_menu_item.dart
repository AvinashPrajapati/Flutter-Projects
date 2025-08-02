import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final IconData icon;
  final String title;
  final void Function(int index) onTap;

  const DrawerMenuItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: isSelected
          ? colorScheme.primary.withAlpha(10)
          : Colors.transparent,
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: colorScheme.primary.withAlpha(10),
        hoverColor: colorScheme.primary.withAlpha(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? colorScheme.primary : null),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? colorScheme.primary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
