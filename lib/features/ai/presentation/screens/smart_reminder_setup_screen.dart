import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/ai/data/models/smart_reminder_model.dart';
import 'package:hybrid_tracker/features/ai/domain/providers/smart_reminder_providers.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/habits/data/models/habit_model.dart';
import 'package:hybrid_tracker/features/habits/domain/providers/habit_providers.dart';

const _uuid = Uuid();

class SmartReminderSetupScreen extends ConsumerWidget {
  const SmartReminderSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    final remindersAsync = ref.watch(smartRemindersProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Smart Reminders', style: AppTypography.titleLarge(onBg)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: gold,
        onPressed: () => _openEditor(context, ref),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: remindersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(
          child: Text('Could not load reminders.', style: AppTypography.bodyMedium(muted)),
        ),
        data: (reminders) {
          if (reminders.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.notifications_active_outlined, size: 56, color: muted),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'No smart reminders yet',
                      style: AppTypography.titleMedium(onBg),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Add a time, place, or contextual nudge to stay on track.',
                      style: AppTypography.bodySmall(muted),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ).animate().fadeIn(duration: 250.ms).scale(begin: const Offset(0.95, 0.95)),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _ReminderCard(reminder: reminder, surface: surface, onSurface: onSurface, muted: muted, gold: gold)
                    .animate(delay: (index * 40).ms)
                    .fadeIn(duration: 220.ms)
                    .slideY(begin: 0.06, end: 0),
              );
            },
          );
        },
      ),
    );
  }

  void _openEditor(BuildContext context, WidgetRef ref, {SmartReminderModel? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: _ReminderEditorSheet(existing: existing),
      ),
    );
  }
}

class _ReminderCard extends ConsumerWidget {
  const _ReminderCard({
    required this.reminder,
    required this.surface,
    required this.onSurface,
    required this.muted,
    required this.gold,
  });

  final SmartReminderModel reminder;
  final Color surface;
  final Color onSurface;
  final Color muted;
  final Color gold;

  IconData get _icon => switch (reminder.triggerType) {
        ReminderTriggerType.time => Icons.schedule_rounded,
        ReminderTriggerType.location => Icons.place_outlined,
        ReminderTriggerType.contextual => Icons.psychology_outlined,
      };

  String get _subtitle => switch (reminder.triggerType) {
        ReminderTriggerType.time =>
          'Daily at ${(reminder.triggerConfig['hour'] as int? ?? 9).toString().padLeft(2, '0')}:${(reminder.triggerConfig['minute'] as int? ?? 0).toString().padLeft(2, '0')}',
        ReminderTriggerType.location => 'When nearby a saved place',
        ReminderTriggerType.contextual => 'If habit still pending later today',
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(smartReminderNotifierProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(_icon, color: gold),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reminder.title, style: AppTypography.bodyLarge(onSurface)),
                const SizedBox(height: 2),
                Text(_subtitle, style: AppTypography.bodySmall(muted)),
                if (reminder.snoozedUntil != null &&
                    reminder.snoozedUntil!.isAfter(DateTime.now())) ...[
                  const SizedBox(height: 2),
                  Text('Snoozed', style: AppTypography.labelSmall(gold)),
                ],
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.snooze_rounded),
            color: muted,
            onPressed: () => notifier.snooze(reminder.id, const Duration(hours: 1)),
          ),
          Switch(
            value: reminder.isActive,
            activeThumbColor: gold,
            onChanged: (_) => notifier.toggleActive(reminder),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            color: AppColors.error,
            onPressed: () => notifier.delete(reminder),
          ),
        ],
      ),
    );
  }
}

class _ReminderEditorSheet extends ConsumerStatefulWidget {
  const _ReminderEditorSheet({this.existing});
  final SmartReminderModel? existing;

  @override
  ConsumerState<_ReminderEditorSheet> createState() => _ReminderEditorSheetState();
}

class _ReminderEditorSheetState extends ConsumerState<_ReminderEditorSheet> {
  late final TextEditingController _titleController;
  ReminderTriggerType _type = ReminderTriggerType.time;
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);
  String? _selectedHabitId;
  String? _selectedLocationTriggerId;
  bool _savingLocation = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existing?.title ?? '');
    if (widget.existing != null) {
      _type = widget.existing!.triggerType;
      final cfg = widget.existing!.triggerConfig;
      if (cfg['hour'] != null) {
        _time = TimeOfDay(hour: cfg['hour'] as int, minute: cfg['minute'] as int? ?? 0);
      }
      _selectedHabitId = cfg['habitId'] as String?;
      _selectedLocationTriggerId = cfg['triggerId'] as String?;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final habitsAsync = ref.watch(allHabitsProvider);
    final locTriggersAsync = ref.watch(locationTriggersProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('New Reminder', style: AppTypography.titleMedium(onSurface)),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _titleController,
                style: AppTypography.bodyMedium(onSurface),
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: AppSpacing.lg),
              SegmentedButton<ReminderTriggerType>(
                segments: const [
                  ButtonSegment(value: ReminderTriggerType.time, label: Text('Time'), icon: Icon(Icons.schedule_rounded)),
                  ButtonSegment(value: ReminderTriggerType.location, label: Text('Place'), icon: Icon(Icons.place_outlined)),
                  ButtonSegment(value: ReminderTriggerType.contextual, label: Text('Habit'), icon: Icon(Icons.psychology_outlined)),
                ],
                selected: {_type},
                onSelectionChanged: (s) => setState(() => _type = s.first),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (_type == ReminderTriggerType.time || _type == ReminderTriggerType.contextual)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Time: ${_time.format(context)}', style: AppTypography.bodyMedium(onSurface)),
                  trailing: Icon(Icons.chevron_right, color: muted),
                  onTap: () async {
                    final picked = await showTimePicker(context: context, initialTime: _time);
                    if (picked != null) setState(() => _time = picked);
                  },
                ),
              if (_type == ReminderTriggerType.contextual)
                habitsAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (habits) => _HabitPicker(
                    habits: habits,
                    selected: _selectedHabitId,
                    onSelected: (id) => setState(() => _selectedHabitId = id),
                    onSurface: onSurface,
                    gold: gold,
                  ),
                ),
              if (_type == ReminderTriggerType.location)
                locTriggersAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (triggers) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final t in triggers)
                        RadioListTile<String>(
                          contentPadding: EdgeInsets.zero,
                          title: Text(t.label, style: AppTypography.bodyMedium(onSurface)),
                          value: t.id,
                          groupValue: _selectedLocationTriggerId,
                          onChanged: (v) => setState(() => _selectedLocationTriggerId = v),
                        ),
                      TextButton.icon(
                        onPressed: _savingLocation ? null : () => _addCurrentLocation(context),
                        icon: const Icon(Icons.add_location_alt_outlined),
                        label: Text(_savingLocation ? 'Getting location…' : 'Save current location'),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _canSave ? () => _save(context) : null,
                  style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Text('Save Reminder'),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  bool get _canSave {
    if (_titleController.text.trim().isEmpty) return false;
    if (_type == ReminderTriggerType.contextual && _selectedHabitId == null) return false;
    if (_type == ReminderTriggerType.location && _selectedLocationTriggerId == null) return false;
    return true;
  }

  Future<void> _addCurrentLocation(BuildContext context) async {
    setState(() => _savingLocation = true);
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission is required to save a place.')),
          );
        }
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
      );
      final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
      final id = _uuid.v4();
      await ref.read(smartReminderNotifierProvider.notifier).saveLocationTrigger(
            LocationTriggerModel(
              id: id,
              userId: userId,
              label: 'Place ${DateTime.now().hour}:${DateTime.now().minute}',
              latitude: position.latitude,
              longitude: position.longitude,
              createdAt: DateTime.now(),
            ),
          );
      setState(() => _selectedLocationTriggerId = id);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not read your location.')),
        );
      }
    } finally {
      if (mounted) setState(() => _savingLocation = false);
    }
  }

  Future<void> _save(BuildContext context) async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final now = DateTime.now();
    final Map<String, dynamic> config = switch (_type) {
      ReminderTriggerType.time => {'hour': _time.hour, 'minute': _time.minute},
      ReminderTriggerType.contextual => {'hour': _time.hour, 'habitId': _selectedHabitId},
      ReminderTriggerType.location => {'triggerId': _selectedLocationTriggerId},
    };

    final reminder = SmartReminderModel(
      id: widget.existing?.id ?? _uuid.v4(),
      userId: userId,
      linkedType: _type == ReminderTriggerType.contextual ? 'habit' : null,
      linkedId: _selectedHabitId,
      title: _titleController.text.trim(),
      triggerType: _type,
      triggerConfig: config,
      isActive: true,
      createdAt: widget.existing?.createdAt ?? now,
      updatedAt: now,
    );

    await ref.read(smartReminderNotifierProvider.notifier).save(reminder);
    if (context.mounted) Navigator.of(context).pop();
  }
}

class _HabitPicker extends StatelessWidget {
  const _HabitPicker({
    required this.habits,
    required this.selected,
    required this.onSelected,
    required this.onSurface,
    required this.gold,
  });

  final List<HabitModel> habits;
  final String? selected;
  final ValueChanged<String> onSelected;
  final Color onSurface;
  final Color gold;

  @override
  Widget build(BuildContext context) {
    if (habits.isEmpty) {
      return Text('No habits yet — create one first.', style: AppTypography.bodySmall(onSurface));
    }
    return Wrap(
      spacing: AppSpacing.sm,
      children: [
        for (final habit in habits)
          ChoiceChip(
            label: Text(habit.name),
            selected: selected == habit.id,
            selectedColor: gold.withValues(alpha: 0.25),
            onSelected: (_) => onSelected(habit.id),
          ),
      ],
    );
  }
}
