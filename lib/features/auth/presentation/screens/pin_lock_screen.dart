import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/data/repositories/pin_repository.dart' show PinVerifyResult;
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/pin_providers.dart';

class PinLockScreen extends ConsumerStatefulWidget {
  const PinLockScreen({super.key});

  @override
  ConsumerState<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends ConsumerState<PinLockScreen> {
  String _entered = '';
  String? _error;
  bool _checking = false;
  Timer? _lockoutTicker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryBiometric());
    // Lockout countdown is otherwise only recomputed on incidental rebuilds
    // (e.g. app foreground/background) — tick every second so it clears live.
    _lockoutTicker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _lockoutTicker?.cancel();
    super.dispose();
  }

  Future<void> _tryBiometric() async {
    final config = await ref.read(pinConfigProvider.future);
    if (config == null || !config.biometricEnabled) return;
    final auth = LocalAuthentication();
    try {
      final canCheck = await auth.canCheckBiometrics && await auth.isDeviceSupported();
      if (!canCheck) return;
      final ok = await auth.authenticate(
        localizedReason: 'Unlock Ryve',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (ok) _unlock();
    } catch (_) {
      // Falls through to PIN entry — biometric hardware may be absent/misconfigured.
    }
  }

  void _unlock() {
    ref.read(appLockedProvider.notifier).state = false;
  }

  Future<void> _onDigit(String d) async {
    if (_checking) return;
    setState(() {
      _entered += d;
      _error = null;
    });
    if (_entered.length == 6) {
      setState(() => _checking = true);
      final userId = ref.read(authStateProvider).value?.uid ?? '';
      final result = await ref.read(pinRepositoryProvider).verifyPin(userId, _entered);
      ref.invalidate(pinConfigProvider);
      switch (result) {
        case PinVerifyResult.correct:
          _unlock();
        case PinVerifyResult.lockedOut:
          setState(() {
            _error = 'Too many attempts. Try again later.';
            _entered = '';
            _checking = false;
          });
        case PinVerifyResult.incorrect:
          setState(() {
            _error = 'Incorrect PIN';
            _entered = '';
            _checking = false;
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(pinConfigProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final lockedUntil = config.valueOrNull?.lockedUntil;
    final isLockedOut = lockedUntil != null && lockedUntil.isAfter(DateTime.now());

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: bg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline_rounded, color: gold, size: 48)
                    .animate()
                    .scale(duration: 300.ms, curve: Curves.easeOut),
                const SizedBox(height: AppSpacing.md),
                Text('Ryve is locked', style: AppTypography.titleLarge(onBg)),
                const SizedBox(height: AppSpacing.sm),
                if (isLockedOut)
                  Text(
                    'Too many attempts. Try again after ${lockedUntil.toLocal().toString().substring(11, 19)}',
                    style: TextStyle(color: AppColors.error),
                    textAlign: TextAlign.center,
                  )
                else ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (i) {
                      final filled = i < _entered.length;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filled ? gold : Colors.transparent,
                          border: Border.all(color: filled ? gold : muted, width: 1.5),
                        ),
                      ).animate(target: filled ? 1 : 0).scale(
                            begin: const Offset(0.8, 0.8),
                            end: const Offset(1, 1),
                            duration: 150.ms,
                          );
                    }),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(_error!, style: TextStyle(color: AppColors.error))
                        .animate()
                        .shake(duration: 300.ms),
                  ],
                  const SizedBox(height: AppSpacing.xl),
                  _PinPad(onDigit: _onDigit, onBackspace: () {
                    if (_entered.isNotEmpty) {
                      setState(() => _entered = _entered.substring(0, _entered.length - 1));
                    }
                  }, onBg: onBg),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PinPad extends StatelessWidget {
  const _PinPad({required this.onDigit, required this.onBackspace, required this.onBg});
  final void Function(String) onDigit;
  final VoidCallback onBackspace;
  final Color onBg;

  @override
  Widget build(BuildContext context) {
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '⌫'];
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.6,
      children: keys.map((k) {
        if (k.isEmpty) return const SizedBox.shrink();
        return TextButton(
          onPressed: () => k == '⌫' ? onBackspace() : onDigit(k),
          child: Text(k, style: TextStyle(fontSize: 22, color: onBg)),
        );
      }).toList(),
    );
  }
}
