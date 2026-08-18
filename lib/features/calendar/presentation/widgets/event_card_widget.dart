import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/calendar/data/models/calendar_event_model.dart';

class EventCardWidget extends StatefulWidget {
  const EventCardWidget({
    super.key,
    required this.event,
    this.onTap,
    this.onDelete,
    this.animationDelay = Duration.zero,
  });

  final CalendarEventModel event;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final Duration animationDelay;

  @override
  State<EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends State<EventCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 80),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return AppColors.darkSecondary;
    }
  }

  String _formatTime(DateTime dt) => DateFormat('h:mm a').format(dt);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark
        ? AppColors.darkOnSurfaceMuted
        : AppColors.lightOnSurfaceMuted;
    final eventColor = _parseColor(widget.event.color);

    final timeLabel = widget.event.isAllDay
        ? 'All day'
        : '${_formatTime(widget.event.startTime)} – ${_formatTime(widget.event.endTime)}';

    Widget card = ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTapDown: (_) => _scaleController.forward(),
        onTapUp: (_) {
          _scaleController.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () => _scaleController.reverse(),
        child: Container(
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  color: eventColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.event.title,
                                style: AppTypography.titleMedium(onSurface),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.onDelete != null)
                              GestureDetector(
                                onTap: widget.onDelete,
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 16,
                                  color: muted,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 13,
                              color: eventColor,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              timeLabel,
                              style: AppTypography.bodySmall(muted),
                            ),
                          ],
                        ),
                        if (widget.event.location != null &&
                            widget.event.location!.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 13,
                                color: muted,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Expanded(
                                child: Text(
                                  widget.event.location!,
                                  style: AppTypography.bodySmall(muted),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (MediaQuery.of(context).disableAnimations) return card;

    return card
        .animate(delay: widget.animationDelay)
        .fadeIn(duration: 200.ms)
        .moveY(begin: 12, end: 0, duration: 200.ms, curve: Curves.easeOut);
  }
}
