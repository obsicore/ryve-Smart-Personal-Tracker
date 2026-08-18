import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_animations.dart';
import 'package:hybrid_tracker/features/dashboard/domain/providers/dashboard_providers.dart';


class NotificationBellWidget extends ConsumerStatefulWidget {
  const NotificationBellWidget({super.key});

  @override
  ConsumerState<NotificationBellWidget> createState() =>
      _NotificationBellWidgetState();
}

class _NotificationBellWidgetState
    extends ConsumerState<NotificationBellWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _swingController;
  int _prevCount = 0;

  @override
  void initState() {
    super.initState();
    _swingController = AnimationController(
      vsync: this,
      duration: AppAnimations.moderate,
    );
  }

  @override
  void dispose() {
    _swingController.dispose();
    super.dispose();
  }

  void _triggerSwing() {
    _swingController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final unread = ref.watch(unreadNotificationsProvider);
    final disableAnims =
        MediaQuery.of(context).disableAnimations;

    if (unread > _prevCount && !disableAnims) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _triggerSwing());
    }
    _prevCount = unread;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark
        ? AppColors.darkOnSurface
        : AppColors.lightOnSurface;

    Widget bell = AnimatedBuilder(
      animation: _swingController,
      builder: (context, child) {
        final t = _swingController.value;
        final angle = t < 1.0
            ? 0.21 *
                (t < 0.25
                    ? t / 0.25
                    : t < 0.5
                        ? 1 - (t - 0.25) / 0.25
                        : t < 0.75
                            ? -(t - 0.5) / 0.25
                            : -(1 - (t - 0.75) / 0.25))
            : 0.0;
        return Transform.rotate(angle: angle, child: child);
      },
      child: Icon(Icons.notifications_outlined, color: iconColor, size: 24),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () {},
          icon: bell,
          tooltip: 'Notifications',
        ),
        if (unread > 0)
          Positioned(
            top: 6,
            right: 6,
            child: _Badge(count: unread, animate: !disableAnims),
          ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final int count;
  final bool animate;

  const _Badge({required this.count, required this.animate});

  @override
  Widget build(BuildContext context) {
    Widget badge = Container(
      width: 16,
      height: 16,
      decoration: const BoxDecoration(
        color: AppColors.error,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        count > 9 ? '9+' : '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );

    if (animate) {
      badge = badge
          .animate()
          .scale(
            begin: const Offset(0, 0),
            end: const Offset(1, 1),
            duration: AppAnimations.moderate,
            curve: AppAnimations.spring,
          );
    }

    return badge;
  }
}
