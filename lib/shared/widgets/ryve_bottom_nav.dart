import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ---------------------------------------------------------------------------
// RyveBottomNav
//
// Custom bottom navigation bar used by all main scaffolded screens.
// 6 tabs: Home, Tasks, Alarm, Sleep, Focus, More (Profile).
//
// Design rules:
//  - 64 dp bar height + MediaQuery.of(context).padding.bottom
//  - Selected: primary-coloured icon + label + 2 dp indicator line above icon
//  - Unselected: onSurfaceMuted colour
//  - Tab switch: icon scale spring (100 ms)
//  - Background: surface colour from theme
// ---------------------------------------------------------------------------

enum RyveTab { home, tasks, alarm, sleep, focus, more }

class RyveBottomNav extends StatelessWidget {
  const RyveBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItem(icon: Icons.home_rounded,         label: 'Home'),
    _NavItem(icon: Icons.check_box_rounded,     label: 'Tasks'),
    _NavItem(icon: Icons.alarm_rounded,         label: 'Alarm'),
    _NavItem(icon: Icons.bedtime_rounded,       label: 'Sleep'),
    _NavItem(icon: Icons.timer_rounded,         label: 'Focus'),
    _NavItem(icon: Icons.person_rounded,        label: 'More'),
  ];

  static const _barHeight = 64.0;

  @override
  Widget build(BuildContext context) {
    final theme      = Theme.of(context);
    final cs         = theme.colorScheme;
    final bottomPad  = MediaQuery.of(context).padding.bottom;
    final primary    = cs.primary;
    final muted      = cs.onSurface.withOpacity(0.45);
    final surface    = cs.surface;

    return Container(
      height: _barHeight + bottomPad,
      decoration: BoxDecoration(
        color: surface,
        border: Border(
          top: BorderSide(
            color: cs.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPad),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(_items.length, (index) {
            final item       = _items[index];
            final isSelected = currentIndex == index;

            return Expanded(
              child: _NavButton(
                item: item,
                isSelected: isSelected,
                selectedColor: primary,
                unselectedColor: muted,
                onTap: () => onTap(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Single navigation button
// ---------------------------------------------------------------------------
class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  final _NavItem item;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? selectedColor : unselectedColor;

    return InkWell(
      onTap: onTap,
      splashColor: selectedColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Indicator line — visible only when selected
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            height: 2,
            width: isSelected ? 24 : 0,
            decoration: BoxDecoration(
              color: selectedColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const SizedBox(height: 6),
          // Icon with spring scale on selection
          Icon(item.icon, color: color, size: 24)
              .animate(
                key: ValueKey('${item.label}_$isSelected'),
                target: isSelected ? 1 : 0,
              )
              .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.18, 1.18),
                duration: 100.ms,
                curve: Curves.elasticOut,
              ),
          const SizedBox(height: 3),
          // Label
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
            child: Text(item.label),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Data class
// ---------------------------------------------------------------------------
class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}
