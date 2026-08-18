import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/wellness/data/models/breathing_session_model.dart';
import 'package:hybrid_tracker/features/wellness/domain/providers/wellness_providers.dart';
import 'package:hybrid_tracker/features/wellness/presentation/widgets/mood_tracker_widget.dart';

enum _BreathPhase { inhale, hold, exhale }

class BreathingSessionScreen extends ConsumerStatefulWidget {
  const BreathingSessionScreen({super.key});

  @override
  ConsumerState<BreathingSessionScreen> createState() => _BreathingSessionScreenState();
}

class _BreathingSessionScreenState extends ConsumerState<BreathingSessionScreen>
    with SingleTickerProviderStateMixin {
  BreathingTechnique _technique = breathingTechniques.first;
  bool _started = false;
  bool _completed = false;
  int _cycles = 0;
  int? _moodBefore;
  int? _moodAfter;
  DateTime? _startedAt;

  late AnimationController _controller;
  _BreathPhase _phase = _BreathPhase.inhale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener(_onStatus);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    setState(() {
      switch (_phase) {
        case _BreathPhase.inhale:
          _phase = _BreathPhase.hold;
          _runPhase();
        case _BreathPhase.hold:
          _phase = _BreathPhase.exhale;
          _runPhase();
        case _BreathPhase.exhale:
          _cycles++;
          _phase = _BreathPhase.inhale;
          _runPhase();
      }
    });
  }

  void _runPhase() {
    final seconds = switch (_phase) {
      _BreathPhase.inhale => _technique.inhaleSec,
      _BreathPhase.hold => _technique.holdSec,
      _BreathPhase.exhale => _technique.exhaleSec,
    };
    _controller.duration = Duration(seconds: seconds);
    _controller.forward(from: 0);
  }

  void _start() {
    setState(() {
      _started = true;
      _startedAt = DateTime.now();
      _phase = _BreathPhase.inhale;
      _cycles = 0;
    });
    _runPhase();
  }

  Future<void> _finish() async {
    _controller.stop();
    setState(() => _completed = true);
  }

  Future<void> _save() async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final now = DateTime.now();
    final session = BreathingSessionModel(
      id: const Uuid().v4(),
      userId: userId,
      technique: _technique.id,
      durationMin: _startedAt == null ? 0 : now.difference(_startedAt!).inMinutes,
      cyclesCompleted: _cycles,
      moodBefore: _moodBefore,
      moodAfter: _moodAfter,
      completed: true,
      startedAt: _startedAt ?? now,
      endedAt: now,
      createdAt: now,
    );
    await ref.read(wellnessNotifierProvider.notifier).logBreathingSession(session);
    if (mounted) Navigator.of(context).pop();
  }

  String get _phaseLabel => switch (_phase) {
        _BreathPhase.inhale => 'Breathe in',
        _BreathPhase.hold => 'Hold',
        _BreathPhase.exhale => 'Breathe out',
      };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Breathing', style: AppTypography.titleLarge(onBg)),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: _completed
            ? _buildComplete(onBg, primary, muted)
            : (_started ? _buildActive(onBg, primary, secondary, muted) : _buildSetup(onBg, primary, muted)),
      ),
    );
  }

  Widget _buildSetup(Color onBg, Color primary, Color muted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose a technique', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: breathingTechniques.map((t) {
            final isSelected = _technique.id == t.id;
            return GestureDetector(
              onTap: () => setState(() => _technique = t),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: isSelected ? primary.withOpacity(0.15) : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(color: isSelected ? primary : muted),
                ),
                child: Text(t.label, style: AppTypography.labelMedium(isSelected ? primary : muted)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('Mood before', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.xs,
          children: [2, 4, 5, 7, 9].map((m) {
            final isSelected = _moodBefore == m;
            return GestureDetector(
              onTap: () => setState(() => _moodBefore = m),
              child: AnimatedScale(
                scale: isSelected ? 1.3 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: Text(moodFaces[m - 1], style: const TextStyle(fontSize: 28)),
              ),
            );
          }).toList(),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _start,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
            ),
            child: Text('Begin', style: AppTypography.labelLarge(Theme.of(context).brightness == Brightness.dark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary)),
          ),
        ),
      ],
    );
  }

  Widget _buildActive(Color onBg, Color primary, Color secondary, Color muted) {
    final color = switch (_phase) {
      _BreathPhase.inhale => primary,
      _BreathPhase.hold => secondary,
      _BreathPhase.exhale => primary,
    };

    return Column(
      children: [
        const Spacer(),
        Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final base = 120.0;
              final growth = 80.0;
              double size;
              if (_phase == _BreathPhase.inhale) {
                size = base + growth * _controller.value;
              } else if (_phase == _BreathPhase.hold) {
                size = base + growth;
              } else {
                size = base + growth * (1 - _controller.value);
              }
              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.15),
                  border: Border.all(color: color, width: 3),
                ),
                alignment: Alignment.center,
                child: Text(_phaseLabel, style: AppTypography.titleMedium(color), textAlign: TextAlign.center),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('Cycles: $_cycles', style: AppTypography.bodyMedium(muted)),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _finish,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
              side: BorderSide(color: primary),
            ),
            child: Text('End Session', style: AppTypography.labelLarge(primary)),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 250.ms);
  }

  Widget _buildComplete(Color onBg, Color primary, Color muted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.self_improvement_rounded, size: 56, color: primary).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
        const SizedBox(height: AppSpacing.md),
        Text('Session complete', style: AppTypography.titleLarge(onBg)),
        Text('$_cycles cycles · ${_technique.label}', style: AppTypography.bodyMedium(muted)),
        const SizedBox(height: AppSpacing.xxl),
        Text('Mood after', style: AppTypography.titleMedium(onBg)),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.xs,
          children: [2, 4, 5, 7, 9].map((m) {
            final isSelected = _moodAfter == m;
            return GestureDetector(
              onTap: () => setState(() => _moodAfter = m),
              child: AnimatedScale(
                scale: isSelected ? 1.3 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: Text(moodFaces[m - 1], style: const TextStyle(fontSize: 28)),
              ),
            );
          }).toList(),
        ),
        if (_moodBefore != null && _moodAfter != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Text(moodFaces[_moodBefore! - 1], style: const TextStyle(fontSize: 20)),
              Icon(Icons.arrow_forward, size: 16, color: muted),
              Text(moodFaces[_moodAfter! - 1], style: const TextStyle(fontSize: 20)),
            ],
          ),
        ],
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
            ),
            child: Text('Save', style: AppTypography.labelLarge(Theme.of(context).brightness == Brightness.dark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary)),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }
}
