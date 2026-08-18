import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:drift/drift.dart' show Value;
import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/shared/widgets/ryve_button.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

// ---------------------------------------------------------------------------
// Onboarding data
// ---------------------------------------------------------------------------

const _goals = [
  'Health',
  'Productivity',
  'Sleep',
  'Focus',
  'Habits',
  'Learning',
  'Finance',
  'Relationships',
];

// ---------------------------------------------------------------------------
// State holders (no persistence needed until step 4 DB write)
// ---------------------------------------------------------------------------

class _OnboardingState {
  final Set<String> selectedGoals;
  final TimeOfDay wakeTime;
  final TimeOfDay sleepTime;

  const _OnboardingState({
    required this.selectedGoals,
    required this.wakeTime,
    required this.sleepTime,
  });

  _OnboardingState copyWith({
    Set<String>? selectedGoals,
    TimeOfDay? wakeTime,
    TimeOfDay? sleepTime,
  }) =>
      _OnboardingState(
        selectedGoals: selectedGoals ?? this.selectedGoals,
        wakeTime: wakeTime ?? this.wakeTime,
        sleepTime: sleepTime ?? this.sleepTime,
      );
}

// ---------------------------------------------------------------------------
// Onboarding Screen
// ---------------------------------------------------------------------------

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  int _step = 0;
  late AnimationController _slideController;
  late Animation<Offset> _slideOut;
  late Animation<Offset> _slideIn;
  bool _animating = false;

  var _data = _OnboardingState(
    selectedGoals: {},
    wakeTime: const TimeOfDay(hour: 7, minute: 0),
    sleepTime: const TimeOfDay(hour: 23, minute: 0),
  );

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _slideOut = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));
    _slideIn = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _advance() async {
    if (_animating) return;
    if (_step < 3) {
      _animating = true;
      await _slideController.forward();
      setState(() => _step++);
      _slideController.reset();
      _animating = false;
    } else {
      final db = ref.read(databaseProvider);
      final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
      if (userId.isNotEmpty) {
        await db.into(db.onboardingResponses).insertOnConflictUpdate(
          OnboardingResponsesCompanion.insert(
            id: const Uuid().v4(),
            userId: userId,
            goalTypes: _data.selectedGoals.join(','),
            wakeTime: Value('${_data.wakeTime.hour.toString().padLeft(2,'0')}:${_data.wakeTime.minute.toString().padLeft(2,'0')}'),
            sleepTime: Value('${_data.sleepTime.hour.toString().padLeft(2,'0')}:${_data.sleepTime.minute.toString().padLeft(2,'0')}'),
            completed: const Value(true),
          ),
        );
      }
      if (mounted) context.go('/');
    }
  }

  String get _buttonLabel {
    switch (_step) {
      case 3:
        return 'Get Started';
      default:
        return 'Next';
    }
  }

  Widget _buildStep(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final mutedColor =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final chipBg = isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;

    switch (_step) {
      case 0:
        return _GoalsStep(
          selectedGoals: _data.selectedGoals,
          onToggle: (goal) {
            setState(() {
              final updated = Set<String>.from(_data.selectedGoals);
              if (updated.contains(goal)) {
                updated.remove(goal);
              } else {
                updated.add(goal);
              }
              _data = _data.copyWith(selectedGoals: updated);
            });
          },
          textColor: textColor,
          mutedColor: mutedColor,
          primaryColor: primaryColor,
          chipBg: chipBg,
        );

      case 1:
        return _TimePickerStep(
          label: 'When do you wake up?',
          icon: Icons.wb_sunny_outlined,
          time: _data.wakeTime,
          onChanged: (t) => setState(() => _data = _data.copyWith(wakeTime: t)),
          textColor: textColor,
          mutedColor: mutedColor,
          primaryColor: primaryColor,
        );

      case 2:
        return _TimePickerStep(
          label: 'When do you sleep?',
          icon: Icons.bedtime_outlined,
          time: _data.sleepTime,
          onChanged: (t) => setState(() => _data = _data.copyWith(sleepTime: t)),
          textColor: textColor,
          mutedColor: mutedColor,
          primaryColor: primaryColor,
        );

      case 3:
        return _CelebrationStep(textColor: textColor, mutedColor: mutedColor);

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final mutedColor =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x3l),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.x3l),

              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  final isActive = i == _step;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? primaryColor : mutedColor.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),

              const SizedBox(height: AppSpacing.x4l),

              // Animated step content
              Expanded(
                child: AnimatedBuilder(
                  animation: _slideController,
                  builder: (context, child) {
                    if (_animating) {
                      return Stack(
                        children: [
                          SlideTransition(
                            position: _slideOut,
                            child: _buildStep(context),
                          ),
                          SlideTransition(
                            position: _slideIn,
                            child: _buildStepFor(_step + 1, context),
                          ),
                        ],
                      );
                    }
                    return _buildStep(context);
                  },
                ),
              ),

              // Next / Finish button
              RyveButton(
                label: _buttonLabel,
                onPressed: _advance,
              ),

              const SizedBox(height: AppSpacing.x3l),
            ],
          ),
        ),
      ),
    );
  }

  // Used during animation to show the next step sliding in
  Widget _buildStepFor(int stepIndex, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final mutedColor =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primaryColor =
        isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    switch (stepIndex) {
      case 1:
        return _TimePickerStep(
          label: 'When do you wake up?',
          icon: Icons.wb_sunny_outlined,
          time: _data.wakeTime,
          onChanged: (_) {},
          textColor: textColor,
          mutedColor: mutedColor,
          primaryColor: primaryColor,
        );
      case 2:
        return _TimePickerStep(
          label: 'When do you sleep?',
          icon: Icons.bedtime_outlined,
          time: _data.sleepTime,
          onChanged: (_) {},
          textColor: textColor,
          mutedColor: mutedColor,
          primaryColor: primaryColor,
        );
      case 3:
        return _CelebrationStep(textColor: textColor, mutedColor: mutedColor);
      default:
        return const SizedBox.shrink();
    }
  }
}

// ---------------------------------------------------------------------------
// Step 1: Goal chips
// ---------------------------------------------------------------------------

class _GoalsStep extends StatelessWidget {
  const _GoalsStep({
    required this.selectedGoals,
    required this.onToggle,
    required this.textColor,
    required this.mutedColor,
    required this.primaryColor,
    required this.chipBg,
  });

  final Set<String> selectedGoals;
  final void Function(String) onToggle;
  final Color textColor;
  final Color mutedColor;
  final Color primaryColor;
  final Color chipBg;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What are your main goals?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Select all that apply — you can change these later.',
          style: TextStyle(fontSize: 14, color: mutedColor),
        ).animate().fadeIn(duration: 280.ms, delay: 60.ms),
        const SizedBox(height: AppSpacing.x3l),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _goals.map((goal) {
            final selected = selectedGoals.contains(goal);
            return GestureDetector(
              onTap: () => onToggle(goal),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: selected ? primaryColor.withValues(alpha: 0.15) : chipBg,
                  borderRadius: BorderRadius.circular(AppSpacing.xl),
                  border: Border.all(
                    color: selected ? primaryColor : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  goal,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected ? primaryColor : textColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ).animate().fadeIn(duration: 280.ms, delay: 100.ms),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Steps 2 & 3: Time picker
// ---------------------------------------------------------------------------

class _TimePickerStep extends StatelessWidget {
  const _TimePickerStep({
    required this.label,
    required this.icon,
    required this.time,
    required this.onChanged,
    required this.textColor,
    required this.mutedColor,
    required this.primaryColor,
  });

  final String label;
  final IconData icon;
  final TimeOfDay time;
  final void Function(TimeOfDay) onChanged;
  final Color textColor;
  final Color mutedColor;
  final Color primaryColor;

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.x4l),
        Center(
          child: GestureDetector(
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: time,
              );
              if (picked != null) onChanged(picked);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.x4l,
                vertical: AppSpacing.x3l,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 1.5),
                borderRadius: BorderRadius.circular(AppSpacing.x3l),
              ),
              child: Column(
                children: [
                  Icon(icon, color: primaryColor, size: 40),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    _formatTime(time),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Tap to change',
                    style: TextStyle(fontSize: 13, color: mutedColor),
                  ),
                ],
              ),
            ),
          ),
        ).animate().fadeIn(duration: 280.ms, delay: 80.ms).scale(begin: const Offset(0.9, 0.9)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Step 4: Celebration
// ---------------------------------------------------------------------------

class _CelebrationStep extends StatelessWidget {
  const _CelebrationStep({
    required this.textColor,
    required this.mutedColor,
  });

  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Confetti Lottie (falls back gracefully if file missing)
        SizedBox(
          width: 220,
          height: 220,
          child: Lottie.asset(
            'assets/animations/confetti.json',
            repeat: false,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.celebration_outlined,
              size: 100,
              color: Color(0xFFC9A84C),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'All set!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms, delay: 300.ms)
            .scale(begin: const Offset(0.7, 0.7), end: const Offset(1, 1)),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Ryve is ready to help you\nrhythm your life · thrive every day',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: mutedColor, height: 1.5),
        ).animate().fadeIn(duration: 400.ms, delay: 450.ms),
      ],
    );
  }
}
