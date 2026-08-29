import 'dart:async';
import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/sleep/data/models/alarm_model.dart';

// ---------------------------------------------------------------------------
// Full-screen alarm ring UI — shown as Stack overlay in main.dart
// ---------------------------------------------------------------------------
class AlarmRingScreen extends StatefulWidget {
  const AlarmRingScreen({
    super.key,
    required this.alarmSettings,
    required this.alarm,
    this.onDismiss,
    this.onSnooze,
  });

  final AlarmSettings alarmSettings;
  final AlarmModel? alarm;
  final VoidCallback? onDismiss;
  final VoidCallback? onSnooze;

  @override
  State<AlarmRingScreen> createState() => _AlarmRingScreenState();
}

class _AlarmRingScreenState extends State<AlarmRingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _glowCtrl;
  late Animation<double> _pulseScale;
  late Animation<double> _glowOpacity;

  final _math = _MathEngine();
  String _answer = '';
  int _solvedCount = 0;
  bool _wrongAnim = false;
  int _snoozesLeft = 0;
  bool _dismissUnlocked = false;
  bool _snoozeUnlocked = false;

  Timer? _clockTimer;
  DateTime _now = DateTime.now();

  int get _required => widget.alarm?.mathProblemCount ?? 3;
  int get _level => widget.alarm?.mathLevel ?? 1;
  AlarmMissionType get _mission =>
      widget.alarm?.missionType ?? AlarmMissionType.none;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _snoozesLeft = widget.alarm?.snoozeCount ?? 3;

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulseScale = Tween<double>(begin: 1.0, end: 1.06)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
    _glowOpacity = Tween<double>(begin: 0.3, end: 0.7)
        .animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });

    if (_mission == AlarmMissionType.none) {
      _dismissUnlocked = true;
      _snoozeUnlocked = true;
    }

    _math.generate(_level);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _glowCtrl.dispose();
    _clockTimer?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _tap(String digit) {
    if (_answer.length >= 6) return;
    setState(() => _answer += digit);
  }

  void _backspace() {
    if (_answer.isEmpty) return;
    setState(() => _answer = _answer.substring(0, _answer.length - 1));
  }

  void _submit() {
    final correct = int.tryParse(_answer) == _math.answer;
    if (correct) {
      _solvedCount++;
      _answer = '';
      _wrongAnim = false;
      if (_solvedCount >= _required) {
        setState(() {
          _dismissUnlocked = true;
          _snoozeUnlocked = true;
        });
      } else {
        _math.generate(_level);
        setState(() {});
      }
    } else {
      setState(() {
        _wrongAnim = true;
        _answer = '';
      });
      Future.delayed(600.ms, () {
        if (mounted) setState(() => _wrongAnim = false);
      });
    }
  }

  void _dismiss() {
    if (!_dismissUnlocked) return;
    Alarm.stop(widget.alarmSettings.id);
    widget.onDismiss?.call();
  }

  void _snooze() {
    if (_snoozesLeft <= 0 || !_snoozeUnlocked) return;
    final minutes = widget.alarm?.snoozeDurationMinutes ?? 5;
    final fireAt = DateTime.now().add(Duration(minutes: minutes));
    Alarm.set(alarmSettings: widget.alarmSettings.copyWith(dateTime: fireAt));
    Alarm.stop(widget.alarmSettings.id);
    setState(() => _snoozesLeft--);
    widget.onSnooze?.call();
  }

  String get _timeString {
    final h = _now.hour;
    final m = _now.minute;
    final period = h >= 12 ? 'PM' : 'AM';
    final dh = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$dh:${m.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    final gold = AppColors.darkPrimary;
    const bg = Color(0xFF0A1510);
    const cardBg = Color(0xFF152B1E);
    final showMath = _mission == AlarmMissionType.math && !_dismissUnlocked;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        color: bg,
        child: SafeArea(
          child: Column(
            children: [
              // ── Clock — Expanded so it gets bounded height, never overflows ─
              Expanded(
                flex: showMath ? 3 : 8,
                child: _ClockSection(
                  timeString: _timeString,
                  label: widget.alarm?.label ?? 'Wake Up',
                  pulseScale: _pulseScale,
                  glowOpacity: _glowOpacity,
                  gold: gold,
                ),
              ),

              // ── Math challenge ────────────────────────────────────────────
              if (showMath)
                Expanded(
                  flex: 6,
                  child: _MathPanel(
                    engine: _math,
                    answer: _answer,
                    solvedCount: _solvedCount,
                    required: _required,
                    wrongAnim: _wrongAnim,
                    onTap: _tap,
                    onBack: _backspace,
                    onSubmit: _submit,
                    gold: gold,
                    cardBg: cardBg,
                  ),
                ),

              // ── Buttons ───────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Row(
                  children: [
                    if (_snoozesLeft > 0) ...[
                      Expanded(
                        child: Opacity(
                          opacity: _snoozeUnlocked ? 1.0 : 0.4,
                          child: OutlinedButton(
                            onPressed: _snoozeUnlocked ? _snooze : null,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white70,
                              side: const BorderSide(color: Colors.white30),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              'Snooze ${widget.alarm?.snoozeDurationMinutes ?? 5}m',
                              style: AppTypography.labelLarge(Colors.white70),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Opacity(
                        opacity: _dismissUnlocked ? 1.0 : 0.35,
                        child: ElevatedButton(
                          onPressed: _dismissUnlocked ? _dismiss : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gold,
                            foregroundColor: const Color(0xFF0A1510),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            _dismissUnlocked ? 'Dismiss' : 'Solve to dismiss',
                            style: AppTypography.labelLarge(
                              _dismissUnlocked
                                  ? const Color(0xFF0A1510)
                                  : Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Clock section — uses LayoutBuilder so ring/text sizes scale to available h
// ---------------------------------------------------------------------------
class _ClockSection extends StatelessWidget {
  const _ClockSection({
    required this.timeString,
    required this.label,
    required this.pulseScale,
    required this.glowOpacity,
    required this.gold,
  });

  final String timeString;
  final String label;
  final Animation<double> pulseScale;
  final Animation<double> glowOpacity;
  final Color gold;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final h = constraints.maxHeight;
      // Scale everything to available height so nothing overflows.
      // Ring occupies 55%, text 35%, 10% padding.
      final ringSize = (h * 0.50).clamp(50.0, 120.0);
      final timeFontSize = (h * 0.20).clamp(22.0, 48.0);
      final labelFontSize = (h * 0.10).clamp(11.0, 18.0);

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([pulseScale, glowOpacity]),
            builder: (_, __) => Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: pulseScale.value * 1.15,
                  child: Container(
                    width: ringSize * 1.3,
                    height: ringSize * 1.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              gold.withValues(alpha: glowOpacity.value * 0.3),
                          blurRadius: 28,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.scale(
                  scale: pulseScale.value,
                  child: Container(
                    width: ringSize,
                    height: ringSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: gold.withValues(alpha: 0.35), width: 2),
                    ),
                  ),
                ),
                Container(
                  width: ringSize * 0.65,
                  height: ringSize * 0.65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: gold.withValues(alpha: 0.10),
                  ),
                  child: Icon(Icons.alarm_rounded,
                      color: gold, size: ringSize * 0.35),
                ),
              ],
            ),
          ),
          SizedBox(height: h * 0.04),
          Text(
            timeString,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: timeFontSize,
              fontWeight: FontWeight.w200,
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: labelFontSize,
              color: Colors.white54,
            ),
          ),
        ],
      );
    });
  }
}

// ---------------------------------------------------------------------------
// Math panel — progress dots + equation card + numpad
// ---------------------------------------------------------------------------
class _MathPanel extends StatelessWidget {
  const _MathPanel({
    required this.engine,
    required this.answer,
    required this.solvedCount,
    required this.required,
    required this.wrongAnim,
    required this.onTap,
    required this.onBack,
    required this.onSubmit,
    required this.gold,
    required this.cardBg,
  });

  final _MathEngine engine;
  final String answer;
  final int solvedCount;
  final int required;
  final bool wrongAnim;
  final ValueChanged<String> onTap;
  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final Color gold;
  final Color cardBg;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final h = constraints.maxHeight;
      // Equation card: a fixed portion; numpad fills the rest.
      final cardH = (h * 0.36).clamp(90.0, 160.0);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Progress dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(required, (i) {
                return AnimatedContainer(
                  duration: 300.ms,
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < solvedCount
                        ? gold
                        : gold.withValues(alpha: 0.2),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),

            // Equation card — fixed height
            SizedBox(
              height: cardH,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: wrongAnim
                        ? AppColors.error.withValues(alpha: 0.7)
                        : gold.withValues(alpha: 0.2),
                    width: wrongAnim ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        engine.questionString,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 36,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedContainer(
                      duration: 200.ms,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 5),
                      decoration: BoxDecoration(
                        color: wrongAnim
                            ? AppColors.error.withValues(alpha: 0.15)
                            : gold.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          answer.isEmpty ? '_ _' : answer,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: wrongAnim ? AppColors.error : gold,
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                    ),
                    if (wrongAnim)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Wrong — try again',
                          style: AppTypography.bodySmall(AppColors.error),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Numpad — Column of Rows, fills all remaining height
            Expanded(
              child: _AdaptiveNumpad(
                onTap: onTap,
                onBack: onBack,
                onSubmit: onSubmit,
                gold: gold,
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ---------------------------------------------------------------------------
// Numpad — Column of Rows so it fills any height without overflow
// ---------------------------------------------------------------------------
class _AdaptiveNumpad extends StatelessWidget {
  const _AdaptiveNumpad({
    required this.onTap,
    required this.onBack,
    required this.onSubmit,
    required this.gold,
  });

  final ValueChanged<String> onTap;
  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final Color gold;

  static const _rows = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
    ['⌫', '0', '✓'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _rows.map((row) {
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: row.map((key) {
              final isSubmit = key == '✓';
              final isBack = key == '⌫';
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: _NumKey(
                    label: key,
                    isSubmit: isSubmit,
                    isBack: isBack,
                    gold: gold,
                    onPressed: () {
                      if (isBack) {
                        onBack();
                      } else if (isSubmit) {
                        onSubmit();
                      } else {
                        onTap(key);
                      }
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class _NumKey extends StatefulWidget {
  const _NumKey({
    required this.label,
    required this.isSubmit,
    required this.isBack,
    required this.gold,
    required this.onPressed,
  });

  final String label;
  final bool isSubmit;
  final bool isBack;
  final Color gold;
  final VoidCallback onPressed;

  @override
  State<_NumKey> createState() => _NumKeyState();
}

class _NumKeyState extends State<_NumKey> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 70),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSubmit
                ? widget.gold
                : (_pressed
                    ? const Color(0xFF1E3D2A)
                    : const Color(0xFF152B1E)),
            borderRadius: BorderRadius.circular(12),
            border: widget.isSubmit
                ? null
                : Border.all(color: Colors.white12),
          ),
          alignment: Alignment.center,
          child: widget.isSubmit
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_rounded,
                        color: const Color(0xFF0A1510), size: 22),
                    const SizedBox(height: 2),
                    Text(
                      'ENTER',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0A1510),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                )
              : Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: widget.isBack ? Colors.white38 : Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Math engine
// ---------------------------------------------------------------------------
class _MathEngine {
  final _rng = Random();
  int _a = 0;
  int _b = 0;
  String _op = '+';

  int get answer => switch (_op) {
        '+' => _a + _b,
        '-' => _a - _b,
        '×' => _a * _b,
        _ => _a + _b,
      };

  String get questionString => '$_a  $_op  $_b  =';

  void generate(int level) {
    final ops = ['+', '-', '×'];
    _op = ops[_rng.nextInt(ops.length)];

    if (level == 1) {
      _a = _rng.nextInt(9) + 1;
      _b = _rng.nextInt(9) + 1;
      if (_op == '-' && _b > _a) {
        final t = _a;
        _a = _b;
        _b = t;
      }
      if (_op == '×') {
        _a = _rng.nextInt(9) + 1;
        _b = _rng.nextInt(9) + 1;
      }
    } else {
      if (_op == '×') {
        _a = _rng.nextInt(10) + 2;
        _b = _rng.nextInt(10) + 2;
      } else {
        _a = _rng.nextInt(90) + 10;
        _b = _rng.nextInt(90) + 10;
        if (_op == '-' && _b > _a) {
          final t = _a;
          _a = _b;
          _b = t;
        }
      }
    }
  }
}
