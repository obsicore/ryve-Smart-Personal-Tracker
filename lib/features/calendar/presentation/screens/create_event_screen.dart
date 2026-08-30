import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/calendar/data/models/calendar_event_model.dart';
import 'package:hybrid_tracker/features/calendar/domain/providers/calendar_providers.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_button.dart';

const _eventColors = [
  '#4CAF82',
  '#C9A84C',
  '#64B5F6',
  '#E57373',
  '#BA68C8',
  '#4DB6AC',
];

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key, this.initialDate, this.existingEvent});

  final DateTime? initialDate;
  final CalendarEventModel? existingEvent;

  bool get isEditing => existingEvent != null;

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  late DateTime _startDate;
  late DateTime _endDate;
  bool _isAllDay = false;
  String _selectedColor = '#4CAF82';

  @override
  void initState() {
    super.initState();
    final ev = widget.existingEvent;
    if (ev != null) {
      _titleController.text = ev.title;
      _descriptionController.text = ev.description ?? '';
      _locationController.text = ev.location ?? '';
      _startDate = ev.startTime;
      _endDate = ev.endTime;
      _isAllDay = ev.isAllDay;
      _selectedColor = ev.color;
    } else {
      final base = widget.initialDate ?? DateTime.now();
      _startDate = DateTime(base.year, base.month, base.day, 9, 0);
      _endDate = DateTime(base.year, base.month, base.day, 10, 0);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked == null) return;
    setState(() {
      _startDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        _startDate.hour,
        _startDate.minute,
      );
      if (_endDate.isBefore(_startDate)) {
        _endDate = _startDate.add(const Duration(hours: 1));
      }
    });
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startDate),
    );
    if (picked == null) return;
    setState(() {
      _startDate = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
        picked.hour,
        picked.minute,
      );
      if (_endDate.isBefore(_startDate)) {
        _endDate = _startDate.add(const Duration(hours: 1));
      }
    });
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime(2035),
    );
    if (picked == null) return;
    setState(() {
      _endDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        _endDate.hour,
        _endDate.minute,
      );
    });
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_endDate),
    );
    if (picked == null) return;
    setState(() {
      _endDate = DateTime(
        _endDate.year,
        _endDate.month,
        _endDate.day,
        picked.hour,
        picked.minute,
      );
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final user = ref.read(authStateProvider).valueOrNull;
    if (user == null) return;

    final now = DateTime.now();
    final existing = widget.existingEvent;

    final event = CalendarEventModel(
      id: existing?.id ?? const Uuid().v4(),
      userId: user.uid,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      location: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
      startTime: _startDate,
      endTime: _endDate,
      isAllDay: _isAllDay,
      color: _selectedColor,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    if (existing != null) {
      await ref.read(calendarNotifierProvider.notifier).updateEvent(event);
    } else {
      await ref.read(calendarNotifierProvider.notifier).createEvent(event);
    }

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final primary =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final onBg =
        isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final onSurface =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final dateFmt = DateFormat('MMM d, yyyy');
    final timeFmt = DateFormat('h:mm a');

    final notifier = ref.watch(calendarNotifierProvider);
    final isSaving = notifier is AsyncLoading;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: onBg),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.isEditing ? 'Edit Event' : 'New Event',
          style: AppTypography.titleLarge(onBg),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _buildField(
              delay: 0,
              child: _textField(
                controller: _titleController,
                label: 'Title',
                hint: 'Event title',
                surface: surface,
                primary: primary,
                onSurface: onSurface,
                muted: muted,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Title is required' : null,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildField(
              delay: 1,
              child: _sectionCard(
                surface: surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'All day',
                            style: AppTypography.bodyMedium(onSurface),
                          ),
                        ),
                        Switch(
                          value: _isAllDay,
                          onChanged: (v) => setState(() => _isAllDay = v),
                          activeThumbColor: primary,
                        ),
                      ],
                    ),
                    const Divider(height: 1),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Start',
                      style: AppTypography.labelSmall(muted),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: _datePill(
                            label: dateFmt.format(_startDate),
                            icon: Icons.calendar_today_rounded,
                            color: primary,
                            onSurface: onSurface,
                            onTap: _pickStartDate,
                          ),
                        ),
                        if (!_isAllDay) ...[
                          const SizedBox(width: AppSpacing.sm),
                          _datePill(
                            label: timeFmt.format(_startDate),
                            icon: Icons.access_time_rounded,
                            color: primary,
                            onSurface: onSurface,
                            onTap: _pickStartTime,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'End',
                      style: AppTypography.labelSmall(muted),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: _datePill(
                            label: dateFmt.format(_endDate),
                            icon: Icons.calendar_today_rounded,
                            color: primary,
                            onSurface: onSurface,
                            onTap: _pickEndDate,
                          ),
                        ),
                        if (!_isAllDay) ...[
                          const SizedBox(width: AppSpacing.sm),
                          _datePill(
                            label: timeFmt.format(_endDate),
                            icon: Icons.access_time_rounded,
                            color: primary,
                            onSurface: onSurface,
                            onTap: _pickEndTime,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildField(
              delay: 2,
              child: _sectionCard(
                surface: surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Color',
                      style: AppTypography.labelSmall(muted),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _eventColors.map((hex) {
                        final c = Color(
                          int.parse(hex.replaceFirst('#', '0xFF')),
                        );
                        final selected = _selectedColor == hex;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedColor = hex),
                          child: AnimatedContainer(
                            duration: 150.ms,
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selected
                                    ? onSurface
                                    : Colors.transparent,
                                width: 2.5,
                              ),
                              boxShadow: selected
                                  ? [
                                      BoxShadow(
                                        color: c.withValues(alpha: 0.5),
                                        blurRadius: 8,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: selected
                                ? Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildField(
              delay: 3,
              child: _textField(
                controller: _locationController,
                label: 'Location',
                hint: 'Add location (optional)',
                surface: surface,
                primary: primary,
                onSurface: onSurface,
                muted: muted,
                prefixIcon: Icons.location_on_outlined,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildField(
              delay: 4,
              child: _textField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Add description (optional)',
                surface: surface,
                primary: primary,
                onSurface: onSurface,
                muted: muted,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: AppSpacing.x3l),
            _buildField(
              delay: 5,
              child: RyveButton(
                label: isSaving ? 'Saving…' : 'Save Event',
                onPressed: isSaving ? null : _save,
                isLoading: isSaving,
              ),
            ),
            const SizedBox(height: AppSpacing.x4l),
          ],
        ),
      ),
    );
  }

  Widget _buildField({required int delay, required Widget child}) {
    if (MediaQuery.of(context).disableAnimations) return child;
    return child
        .animate(delay: Duration(milliseconds: delay * 50 + 50))
        .fadeIn(duration: 220.ms)
        .moveY(begin: 16, end: 0, duration: 220.ms, curve: Curves.easeOut);
  }

  Widget _sectionCard({required Color surface, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: child,
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required Color surface,
    required Color primary,
    required Color onSurface,
    required Color muted,
    String? Function(String?)? validator,
    int maxLines = 1,
    IconData? prefixIcon,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: AppTypography.bodyMedium(onSurface),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: AppTypography.bodySmall(muted),
        hintStyle: AppTypography.bodySmall(muted),
        filled: true,
        fillColor: surface,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: muted, size: 20)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
    );
  }

  Widget _datePill({
    required String label,
    required IconData icon,
    required Color color,
    required Color onSurface,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                label,
                style: AppTypography.bodySmall(color).copyWith(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
