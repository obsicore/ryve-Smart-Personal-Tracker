import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/habits/data/models/habit_model.dart';
import 'package:hybrid_tracker/features/habits/domain/providers/habit_providers.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_button.dart';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------
const _icons = [
  '⭐', '🏃', '💧', '📚', '💪', '🧘', '🎯', '🌱',
  '🎵', '💤', '🍎', '🏋️', '📝', '🎨', '🌍', '💡',
  '🧠', '❤️', '⚡', '🔥',
];

const _categories = [
  'Health', 'Productivity', 'Learning', 'Mindfulness', 'Fitness', 'Custom',
];

const _frequencies = ['Daily', 'Weekly', 'Custom'];

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------
class CreateHabitScreen extends ConsumerStatefulWidget {
  const CreateHabitScreen({super.key});

  @override
  ConsumerState<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends ConsumerState<CreateHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _unitController = TextEditingController();
  final _targetController = TextEditingController(text: '1');

  String _selectedIcon = '⭐';
  String _selectedCategory = 'Health';
  String _selectedFrequency = 'Daily';
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _unitController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final targetValue = int.tryParse(_targetController.text.trim()) ?? 1;

    final habit = HabitModel(
      id: const Uuid().v4(),
      userId: userId,
      name: _nameController.text.trim(),
      iconEmoji: _selectedIcon,
      category: _selectedCategory.toLowerCase(),
      frequency: _selectedFrequency.toLowerCase(),
      targetValue: targetValue,
      unit: _unitController.text.trim().isEmpty
          ? null
          : _unitController.text.trim(),
      createdAt: DateTime.now(),
    );

    setState(() => _saving = true);
    try {
      await ref.read(habitNotifierProvider.notifier).createHabit(habit);
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        elevation: 0,
        leading: BackButton(color: cs.onSurface),
        title: Text(
          'New Habit',
          style: AppTypography.titleLarge(onSurface),
        ),
      ),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Name input
                  _SectionLabel(label: 'Habit Name', isDark: isDark),
                  const SizedBox(height: AppSpacing.sm),
                  _NameField(
                    controller: _nameController,
                    isDark: isDark,
                    primary: primary,
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Icon picker
                  _SectionLabel(label: 'Choose Icon', isDark: isDark),
                  const SizedBox(height: AppSpacing.md),
                  _IconPicker(
                    selected: _selectedIcon,
                    isDark: isDark,
                    primary: primary,
                    disableAnimations: disableAnimations,
                    onSelect: (icon) => setState(() => _selectedIcon = icon),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Category chips
                  _SectionLabel(label: 'Category', isDark: isDark),
                  const SizedBox(height: AppSpacing.md),
                  _ChipSelector(
                    options: _categories,
                    selected: _selectedCategory,
                    primary: primary,
                    isDark: isDark,
                    onSelect: (v) => setState(() => _selectedCategory = v),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Frequency chips
                  _SectionLabel(label: 'Frequency', isDark: isDark),
                  const SizedBox(height: AppSpacing.md),
                  _ChipSelector(
                    options: _frequencies,
                    selected: _selectedFrequency,
                    primary: primary,
                    isDark: isDark,
                    onSelect: (v) => setState(() => _selectedFrequency = v),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Target + Unit row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionLabel(label: 'Target', isDark: isDark),
                            const SizedBox(height: AppSpacing.sm),
                            _NumberField(
                              controller: _targetController,
                              isDark: isDark,
                              primary: primary,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionLabel(
                              label: 'Unit (optional)',
                              isDark: isDark,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _UnitField(
                              controller: _unitController,
                              isDark: isDark,
                              primary: primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.x3l),

                  // Create button
                  RyveButton(
                    label: 'Create Habit',
                    isLoading: _saving,
                    onPressed: _saving ? null : _save,
                  ),
                  SizedBox(
                    height: AppSpacing.xxl + MediaQuery.of(context).padding.bottom,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section label
// ---------------------------------------------------------------------------
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.isDark});

  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.labelMedium(
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Name text field
// ---------------------------------------------------------------------------
class _NameField extends StatelessWidget {
  const _NameField({
    required this.controller,
    required this.isDark,
    required this.primary,
  });

  final TextEditingController controller;
  final bool isDark;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final surface =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;

    return TextFormField(
      controller: controller,
      style: AppTypography.bodyLarge(onSurface),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        hintText: 'e.g. Morning Meditation',
        hintStyle: AppTypography.bodyLarge(
          (isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted)
              .withOpacity(0.5),
        ),
        filled: true,
        fillColor: surface,
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Name is required';
        if (v.trim().length < 2) return 'Name must be at least 2 characters';
        return null;
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Number input for target
// ---------------------------------------------------------------------------
class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.controller,
    required this.isDark,
    required this.primary,
  });

  final TextEditingController controller;
  final bool isDark;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final surface =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;

    return TextFormField(
      controller: controller,
      style: AppTypography.bodyLarge(onSurface),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: '1',
        hintStyle: AppTypography.bodyLarge(
          (isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted)
              .withOpacity(0.5),
        ),
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Required';
        final n = int.tryParse(v.trim());
        if (n == null || n < 1) return 'Min 1';
        return null;
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Unit text input
// ---------------------------------------------------------------------------
class _UnitField extends StatelessWidget {
  const _UnitField({
    required this.controller,
    required this.isDark,
    required this.primary,
  });

  final TextEditingController controller;
  final bool isDark;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final surface =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;

    return TextField(
      controller: controller,
      style: AppTypography.bodyLarge(onSurface),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: 'cups, pages, mins…',
        hintStyle: AppTypography.bodyLarge(
          (isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted)
              .withOpacity(0.5),
        ),
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Icon picker grid — 20 emoji, selected scales to 1.3×
// ---------------------------------------------------------------------------
class _IconPicker extends StatelessWidget {
  const _IconPicker({
    required this.selected,
    required this.isDark,
    required this.primary,
    required this.disableAnimations,
    required this.onSelect,
  });

  final String selected;
  final bool isDark;
  final Color primary;
  final bool disableAnimations;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final selectedBg =
        isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceBright;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1,
      ),
      itemCount: _icons.length,
      itemBuilder: (context, i) {
        final icon = _icons[i];
        final isSelected = icon == selected;

        Widget cell = GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            onSelect(icon);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: isSelected ? selectedBg : surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: isSelected
                  ? Border.all(color: primary, width: 2)
                  : null,
            ),
            alignment: Alignment.center,
            child: AnimatedScale(
              scale: isSelected ? 1.3 : 1.0,
              duration: disableAnimations
                  ? Duration.zero
                  : const Duration(milliseconds: 200),
              curve: Curves.elasticOut,
              child: Text(icon, style: const TextStyle(fontSize: 22)),
            ),
          ),
        );

        return cell;
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Chip selector — wrapping row of filter chips
// ---------------------------------------------------------------------------
class _ChipSelector extends StatelessWidget {
  const _ChipSelector({
    required this.options,
    required this.selected,
    required this.primary,
    required this.isDark,
    required this.onSelect,
  });

  final List<String> options;
  final String selected;
  final Color primary;
  final bool isDark;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: options.map((option) {
        final isSelected = option == selected;
        final surface =
            isDark ? AppColors.darkSurface : AppColors.lightSurface;
        final muted =
            isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            onSelect(option);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isSelected ? primary : surface,
              borderRadius: BorderRadius.circular(AppRadius.full),
              border: isSelected
                  ? null
                  : Border.all(
                      color: isDark
                          ? AppColors.darkSurfaceBright
                          : AppColors.lightSurfaceVariant,
                      width: 1,
                    ),
            ),
            child: Text(
              option,
              style: AppTypography.labelMedium(
                isSelected ? AppColors.darkBackground : muted,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
