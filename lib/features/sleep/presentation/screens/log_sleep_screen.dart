import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/sleep/data/models/sleep_log_model.dart';
import 'package:hybrid_tracker/features/sleep/domain/providers/sleep_providers.dart';

class LogSleepScreen extends ConsumerStatefulWidget {
  final SleepLogModel? existing;

  const LogSleepScreen({super.key, this.existing});

  @override
  ConsumerState<LogSleepScreen> createState() => _LogSleepScreenState();
}

class _LogSleepScreenState extends ConsumerState<LogSleepScreen> {
  late DateTime _bedtime;
  late DateTime _wakeTime;
  late int _qualityRating;
  final _notesController = TextEditingController();
  bool _saving = false;

  static const _qualityEmojis = ['😴', '😐', '😊', '😄', '🌟'];

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    if (existing != null) {
      _bedtime = existing.bedtime;
      _wakeTime = existing.wakeTime;
      _qualityRating = existing.qualityRating;
      _notesController.text = existing.notes ?? '';
    } else {
      final now = DateTime.now();
      _wakeTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);
      _bedtime = _wakeTime.subtract(const Duration(hours: 8));
      _qualityRating = 3;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Duration get _duration => _wakeTime.difference(_bedtime);

  String get _durationText {
    final h = _duration.inHours;
    final m = _duration.inMinutes % 60;
    return '${h}h ${m}m';
  }

  Future<void> _pickBedtime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_bedtime),
    );
    if (picked != null && mounted) {
      setState(() {
        _bedtime = DateTime(
          _bedtime.year,
          _bedtime.month,
          _bedtime.day,
          picked.hour,
          picked.minute,
        );
        if (_wakeTime.isBefore(_bedtime)) {
          _wakeTime = _bedtime.add(const Duration(hours: 8));
        }
      });
    }
  }

  Future<void> _pickWakeTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_wakeTime),
    );
    if (picked != null && mounted) {
      setState(() {
        _wakeTime = DateTime(
          _wakeTime.year,
          _wakeTime.month,
          _wakeTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);

    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final notifier = ref.read(sleepNotifierProvider.notifier);

    final log = SleepLogModel(
      id: widget.existing?.id ?? const Uuid().v4(),
      userId: userId,
      bedtime: _bedtime,
      wakeTime: _wakeTime,
      qualityRating: _qualityRating,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      createdAt: widget.existing?.createdAt ?? DateTime.now(),
    );

    if (widget.existing != null) {
      await notifier.updateLog(log);
    } else {
      await notifier.logSleep(log);
    }

    if (mounted) Navigator.of(context).pop();
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour;
    final m = dt.minute;
    final period = h >= 12 ? 'PM' : 'AM';
    final displayH = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$displayH:${m.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text(
          widget.existing != null ? 'Edit Sleep Log' : 'Log Sleep',
          style: AppTypography.titleLarge(onBg),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Duration display
            Center(
              child: Column(
                children: [
                  Text(_durationText, style: AppTypography.displayLarge(secondary)),
                  Text('sleep duration', style: AppTypography.bodySmall(muted)),
                ],
              ),
            ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.06, end: 0),

            const SizedBox(height: AppSpacing.xxl),

            // Bedtime picker
            _TimePickerRow(
              label: 'Bedtime',
              icon: Icons.bedtime_outlined,
              time: _formatTime(_bedtime),
              onTap: _pickBedtime,
              isDark: isDark,
              surface: surface,
              onSurface: onSurface,
              muted: muted,
            ).animate(delay: 60.ms).fadeIn(duration: 250.ms).slideY(begin: 0.06, end: 0),

            const SizedBox(height: AppSpacing.md),

            // Wake time picker
            _TimePickerRow(
              label: 'Wake Time',
              icon: Icons.wb_sunny_outlined,
              time: _formatTime(_wakeTime),
              onTap: _pickWakeTime,
              isDark: isDark,
              surface: surface,
              onSurface: onSurface,
              muted: muted,
            ).animate(delay: 120.ms).fadeIn(duration: 250.ms).slideY(begin: 0.06, end: 0),

            const SizedBox(height: AppSpacing.xxl),

            // Quality selector
            Text('Sleep Quality', style: AppTypography.titleMedium(onBg))
                .animate(delay: 180.ms).fadeIn(duration: 250.ms),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _qualityEmojis.asMap().entries.map((entry) {
                final i = entry.key;
                final rating = i + 1;
                final isSelected = _qualityRating == rating;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _qualityRating = rating);
                  },
                  child: AnimatedScale(
                    scale: isSelected ? 1.3 : 0.9,
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.elasticOut,
                    child: Text(
                      entry.value,
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                );
              }).toList(),
            ).animate(delay: 180.ms).fadeIn(duration: 250.ms),

            const SizedBox(height: AppSpacing.xxl),

            // Notes
            Text('Notes (optional)', style: AppTypography.titleMedium(onBg))
                .animate(delay: 240.ms).fadeIn(duration: 250.ms),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _notesController,
              maxLines: 3,
              style: AppTypography.bodyMedium(onSurface),
              decoration: InputDecoration(
                hintText: 'How did you sleep?',
                hintStyle: AppTypography.bodyMedium(muted),
                filled: true,
                fillColor: surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: isDark ? BorderSide(color: AppColors.darkSurfaceBright) : BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: isDark ? BorderSide(color: AppColors.darkSurfaceBright) : BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  borderSide: BorderSide(color: primary, width: 2),
                ),
              ),
            ).animate(delay: 240.ms).fadeIn(duration: 250.ms),

            const SizedBox(height: AppSpacing.x3l),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
                ),
                child: _saving
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text('Save Sleep Log', style: AppTypography.labelLarge(isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary)),
              ),
            ).animate(delay: 300.ms).fadeIn(duration: 250.ms).slideY(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }
}

class _TimePickerRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final String time;
  final VoidCallback onTap;
  final bool isDark;
  final Color surface;
  final Color onSurface;
  final Color muted;

  const _TimePickerRow({
    required this.label,
    required this.icon,
    required this.time,
    required this.onTap,
    required this.isDark,
    required this.surface,
    required this.onSurface,
    required this.muted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: muted),
            const SizedBox(width: AppSpacing.md),
            Text(label, style: AppTypography.bodyMedium(muted)),
            const Spacer(),
            Text(time, style: AppTypography.titleMedium(onSurface)),
            const SizedBox(width: AppSpacing.sm),
            Icon(Icons.chevron_right, size: 20, color: muted),
          ],
        ),
      ),
    );
  }
}
