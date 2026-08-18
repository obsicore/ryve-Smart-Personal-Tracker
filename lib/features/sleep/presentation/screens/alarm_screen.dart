import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/sleep/data/models/alarm_model.dart';
import 'package:hybrid_tracker/features/sleep/domain/providers/sleep_providers.dart';

class AlarmScreen extends ConsumerStatefulWidget {
  const AlarmScreen({super.key, this.existing});

  final AlarmModel? existing;

  @override
  ConsumerState<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends ConsumerState<AlarmScreen> {
  late TimeOfDay _time;
  late TextEditingController _labelCtrl;
  late Set<int> _days;
  late AlarmMissionType _mission;
  late int _snoozeCount;
  late int _snoozeDuration;
  bool _saving = false;
  bool _timeAnimating = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    if (existing != null) {
      final parts = existing.time.split(':');
      _time = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
      _labelCtrl = TextEditingController(text: existing.label);
      _days = existing.activeDays.toSet();
      _mission = existing.missionType;
      _snoozeCount = existing.snoozeCount;
      _snoozeDuration = existing.snoozeDurationMinutes;
    } else {
      _time = const TimeOfDay(hour: 6, minute: 0);
      _labelCtrl = TextEditingController(text: 'Wake Up');
      _days = {1, 2, 3, 4, 5, 6, 7};
      _mission = AlarmMissionType.none;
      _snoozeCount = 3;
      _snoozeDuration = 5;
    }
  }

  @override
  void dispose() {
    _labelCtrl.dispose();
    super.dispose();
  }

  String get _timeFormatted {
    final h = _time.hour;
    final m = _time.minute;
    final period = h >= 12 ? 'PM' : 'AM';
    final dh = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$dh:${m.toString().padLeft(2, '0')} $period';
  }

  String get _daysString {
    final sorted = _days.toList()..sort();
    return sorted.join(',');
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (result != null) {
      setState(() {
        _time = result;
        _timeAnimating = true;
      });
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (mounted) setState(() => _timeAnimating = false);
    }
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);

    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final now = DateTime.now();

    try {
      final notifier = ref.read(alarmNotifierProvider.notifier);
      if (widget.existing != null) {
        await notifier.updateAlarm(
          widget.existing!.copyWith(
            label: _labelCtrl.text.trim().isEmpty
                ? 'Wake Up'
                : _labelCtrl.text.trim(),
            time:
                '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}',
            daysOfWeek: _daysString,
            missionType: _mission,
            snoozeCount: _snoozeCount,
            snoozeDurationMinutes: _snoozeDuration,
          ),
        );
      } else {
        await notifier.create(
          AlarmModel(
            id: newAlarmId,
            userId: userId,
            label: _labelCtrl.text.trim().isEmpty
                ? 'Wake Up'
                : _labelCtrl.text.trim(),
            time:
                '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}',
            daysOfWeek: _daysString,
            missionType: _mission,
            snoozeCount: _snoozeCount,
            snoozeDurationMinutes: _snoozeDuration,
            createdAt: now,
          ),
        );
      }
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save alarm. Try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceBright =
        isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceBright;
    final onBg =
        isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final onSurface =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary =
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final onPrimary =
        isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary;
    final disableAnims = MediaQuery.of(context).disableAnimations;

    final isEdit = widget.existing != null;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text(
          isEdit ? 'Edit Alarm' : 'New Alarm',
          style: AppTypography.titleLarge(onBg),
        ),
        actions: isEdit
            ? [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.error),
                  onPressed: () async {
                    final nav = Navigator.of(context);
                    await ref
                        .read(alarmNotifierProvider.notifier)
                        .delete(widget.existing!.id);
                    if (!mounted) return;
                    nav.pop();
                  },
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.x4l,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TimeDisplay(
              timeFormatted: _timeFormatted,
              onTap: _pickTime,
              animating: _timeAnimating,
              onSurface: onSurface,
              surface: surface,
              surfaceBright: surfaceBright,
              isDark: isDark,
              index: 0,
              disableAnims: disableAnims,
            ),
            const SizedBox(height: AppSpacing.x3l),
            _SectionLabel(
              text: 'Repeat',
              muted: muted,
              index: 1,
              disableAnims: disableAnims,
            ),
            const SizedBox(height: AppSpacing.md),
            _DaySelector(
              selected: _days,
              onToggle: (d) => setState(() {
                if (_days.contains(d)) {
                  if (_days.length > 1) _days.remove(d);
                } else {
                  _days.add(d);
                }
              }),
              primary: primary,
              onPrimary: onPrimary,
              muted: muted,
              surface: surface,
              surfaceBright: surfaceBright,
              isDark: isDark,
              index: 2,
              disableAnims: disableAnims,
            ),
            const SizedBox(height: AppSpacing.x3l),
            _SectionLabel(
              text: 'Label',
              muted: muted,
              index: 3,
              disableAnims: disableAnims,
            ),
            const SizedBox(height: AppSpacing.md),
            _LabelField(
              controller: _labelCtrl,
              isDark: isDark,
              surface: surface,
              surfaceBright: surfaceBright,
              onSurface: onSurface,
              muted: muted,
              secondary: secondary,
              index: 4,
              disableAnims: disableAnims,
            ),
            const SizedBox(height: AppSpacing.x3l),
            _SectionLabel(
              text: 'Wake-Up Mission',
              muted: muted,
              index: 5,
              disableAnims: disableAnims,
            ),
            const SizedBox(height: AppSpacing.md),
            _MissionSelector(
              selected: _mission,
              onSelect: (m) => setState(() => _mission = m),
              primary: primary,
              onSurface: onSurface,
              muted: muted,
              surface: surface,
              surfaceBright: surfaceBright,
              isDark: isDark,
              index: 6,
              disableAnims: disableAnims,
            ),
            const SizedBox(height: AppSpacing.x3l),
            _SectionLabel(
              text: 'Snooze Settings',
              muted: muted,
              index: 7,
              disableAnims: disableAnims,
            ),
            const SizedBox(height: AppSpacing.md),
            _SnoozeSettings(
              snoozeCount: _snoozeCount,
              snoozeDuration: _snoozeDuration,
              onCountChange: (v) => setState(() => _snoozeCount = v),
              onDurationChange: (v) => setState(() => _snoozeDuration = v),
              onSurface: onSurface,
              muted: muted,
              primary: primary,
              surface: surface,
              surfaceBright: surfaceBright,
              isDark: isDark,
              index: 8,
              disableAnims: disableAnims,
            ),
            const SizedBox(height: AppSpacing.x3l),
            _SaveButton(
              saving: _saving,
              onSave: _save,
              primary: primary,
              onPrimary: onPrimary,
              index: 9,
              disableAnims: disableAnims,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.text,
    required this.muted,
    required this.index,
    required this.disableAnims,
  });
  final String text;
  final Color muted;
  final int index;
  final bool disableAnims;

  @override
  Widget build(BuildContext context) {
    Widget label = Text(text, style: AppTypography.labelMedium(muted));
    if (!disableAnims) {
      label = label
          .animate(delay: (index * 60).ms)
          .fadeIn(duration: 200.ms, curve: Curves.easeOut);
    }
    return label;
  }
}

class _TimeDisplay extends StatelessWidget {
  const _TimeDisplay({
    required this.timeFormatted,
    required this.onTap,
    required this.animating,
    required this.onSurface,
    required this.surface,
    required this.surfaceBright,
    required this.isDark,
    required this.index,
    required this.disableAnims,
  });
  final String timeFormatted;
  final VoidCallback onTap;
  final bool animating;
  final Color onSurface;
  final Color surface;
  final Color surfaceBright;
  final bool isDark;
  final int index;
  final bool disableAnims;

  @override
  Widget build(BuildContext context) {
    Widget content = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.x3l),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: isDark ? Border.all(color: surfaceBright, width: 1) : null,
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) => ScaleTransition(
            scale: anim,
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: Text(
            timeFormatted,
            key: ValueKey(timeFormatted),
            style: AppTypography.displayLarge(onSurface),
          ),
        ),
      ),
    );
    if (!disableAnims) {
      content = content
          .animate(delay: (index * 60).ms)
          .fadeIn(duration: 280.ms, curve: Curves.easeOut)
          .slideY(begin: 0.06, end: 0, duration: 280.ms);
    }
    return content;
  }
}

class _DaySelector extends StatelessWidget {
  const _DaySelector({
    required this.selected,
    required this.onToggle,
    required this.primary,
    required this.onPrimary,
    required this.muted,
    required this.surface,
    required this.surfaceBright,
    required this.isDark,
    required this.index,
    required this.disableAnims,
  });
  final Set<int> selected;
  final ValueChanged<int> onToggle;
  final Color primary;
  final Color onPrimary;
  final Color muted;
  final Color surface;
  final Color surfaceBright;
  final bool isDark;
  final int index;
  final bool disableAnims;

  static const _labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    Widget row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final day = i + 1;
        final isSelected = selected.contains(day);
        return GestureDetector(
          onTap: () => onToggle(day),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? primary : surface,
              border: Border.all(
                color: isSelected ? primary : surfaceBright,
                width: 1.5,
              ),
            ),
            child: Text(
              _labels[i],
              style: AppTypography.labelMedium(isSelected ? onPrimary : muted),
            ),
          ),
        );
      }),
    );
    if (!disableAnims) {
      row = row
          .animate(delay: (index * 60).ms)
          .fadeIn(duration: 220.ms, curve: Curves.easeOut)
          .slideY(begin: 0.06, end: 0, duration: 220.ms);
    }
    return row;
  }
}

class _LabelField extends StatelessWidget {
  const _LabelField({
    required this.controller,
    required this.isDark,
    required this.surface,
    required this.surfaceBright,
    required this.onSurface,
    required this.muted,
    required this.secondary,
    required this.index,
    required this.disableAnims,
  });
  final TextEditingController controller;
  final bool isDark;
  final Color surface;
  final Color surfaceBright;
  final Color onSurface;
  final Color muted;
  final Color secondary;
  final int index;
  final bool disableAnims;

  @override
  Widget build(BuildContext context) {
    Widget field = TextField(
      controller: controller,
      style: AppTypography.bodyMedium(onSurface),
      decoration: InputDecoration(
        hintText: 'Wake Up',
        hintStyle: AppTypography.bodyMedium(muted),
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide:
              isDark ? BorderSide(color: surfaceBright) : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide:
              isDark ? BorderSide(color: surfaceBright) : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: secondary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    );
    if (!disableAnims) {
      field = field
          .animate(delay: (index * 60).ms)
          .fadeIn(duration: 220.ms, curve: Curves.easeOut)
          .slideY(begin: 0.06, end: 0, duration: 220.ms);
    }
    return field;
  }
}

class _MissionSelector extends StatelessWidget {
  const _MissionSelector({
    required this.selected,
    required this.onSelect,
    required this.primary,
    required this.onSurface,
    required this.muted,
    required this.surface,
    required this.surfaceBright,
    required this.isDark,
    required this.index,
    required this.disableAnims,
  });
  final AlarmMissionType selected;
  final ValueChanged<AlarmMissionType> onSelect;
  final Color primary;
  final Color onSurface;
  final Color muted;
  final Color surface;
  final Color surfaceBright;
  final bool isDark;
  final int index;
  final bool disableAnims;

  static const _options = [
    (type: AlarmMissionType.none, icon: Icons.do_not_disturb_alt, label: 'No Mission'),
    (type: AlarmMissionType.math, icon: Icons.calculate_outlined, label: 'Math Problem'),
    (type: AlarmMissionType.shake, icon: Icons.vibration, label: 'Shake to Dismiss'),
  ];

  @override
  Widget build(BuildContext context) {
    Widget cards = Row(
      children: _options.map((opt) {
        final isSelected = selected == opt.type;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(opt.type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.md,
                horizontal: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isSelected ? primary.withValues(alpha: 0.12) : surface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: isSelected ? primary : surfaceBright,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    opt.icon,
                    color: isSelected ? primary : muted,
                    size: 24,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    opt.label,
                    style: AppTypography.labelSmall(
                      isSelected ? primary : muted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
    if (!disableAnims) {
      cards = cards
          .animate(delay: (index * 60).ms)
          .fadeIn(duration: 220.ms, curve: Curves.easeOut)
          .slideY(begin: 0.06, end: 0, duration: 220.ms);
    }
    return cards;
  }
}

class _SnoozeSettings extends StatelessWidget {
  const _SnoozeSettings({
    required this.snoozeCount,
    required this.snoozeDuration,
    required this.onCountChange,
    required this.onDurationChange,
    required this.onSurface,
    required this.muted,
    required this.primary,
    required this.surface,
    required this.surfaceBright,
    required this.isDark,
    required this.index,
    required this.disableAnims,
  });
  final int snoozeCount;
  final int snoozeDuration;
  final ValueChanged<int> onCountChange;
  final ValueChanged<int> onDurationChange;
  final Color onSurface;
  final Color muted;
  final Color primary;
  final Color surface;
  final Color surfaceBright;
  final bool isDark;
  final int index;
  final bool disableAnims;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: isDark ? Border.all(color: surfaceBright, width: 1) : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          _StepperRow(
            label: 'Snooze count',
            value: snoozeCount,
            min: 0,
            max: 10,
            onChanged: onCountChange,
            suffix: 'times',
            onSurface: onSurface,
            muted: muted,
            primary: primary,
          ),
          const Divider(height: AppSpacing.x3l),
          _StepperRow(
            label: 'Snooze duration',
            value: snoozeDuration,
            min: 1,
            max: 30,
            onChanged: onDurationChange,
            suffix: 'min',
            onSurface: onSurface,
            muted: muted,
            primary: primary,
          ),
        ],
      ),
    );
    if (!disableAnims) {
      content = content
          .animate(delay: (index * 60).ms)
          .fadeIn(duration: 220.ms, curve: Curves.easeOut)
          .slideY(begin: 0.06, end: 0, duration: 220.ms);
    }
    return content;
  }
}

class _StepperRow extends StatelessWidget {
  const _StepperRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.suffix,
    required this.onSurface,
    required this.muted,
    required this.primary,
  });
  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;
  final String suffix;
  final Color onSurface;
  final Color muted;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTypography.bodyMedium(muted))),
        IconButton(
          icon: Icon(Icons.remove_circle_outline, color: primary),
          onPressed: value > min ? () => onChanged(value - 1) : null,
          padding: EdgeInsets.zero,
        ),
        SizedBox(
          width: 52,
          child: Text(
            '$value $suffix',
            style: AppTypography.titleMedium(onSurface),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline, color: primary),
          onPressed: value < max ? () => onChanged(value + 1) : null,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.saving,
    required this.onSave,
    required this.primary,
    required this.onPrimary,
    required this.index,
    required this.disableAnims,
  });
  final bool saving;
  final VoidCallback onSave;
  final Color primary;
  final Color onPrimary;
  final int index;
  final bool disableAnims;

  @override
  Widget build(BuildContext context) {
    Widget btn = SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: saving ? null : onSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          disabledBackgroundColor: primary.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
        ),
        child: saving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Text(
                'Save Alarm',
                style: AppTypography.labelLarge(onPrimary),
              ),
      ),
    );
    if (!disableAnims) {
      btn = btn
          .animate(delay: (index * 60).ms)
          .fadeIn(duration: 220.ms, curve: Curves.easeOut)
          .slideY(begin: 0.06, end: 0, duration: 220.ms);
    }
    return btn;
  }
}
