import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/pin_providers.dart';

Future<void> showPinSetupSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => const _PinSetupSheet(),
  );
}

class _PinSetupSheet extends ConsumerStatefulWidget {
  const _PinSetupSheet();

  @override
  ConsumerState<_PinSetupSheet> createState() => _PinSetupSheetState();
}

class _PinSetupSheetState extends ConsumerState<_PinSetupSheet> {
  String _first = '';
  String _entered = '';
  bool _confirming = false;
  String? _error;

  void _onDigit(String d) {
    setState(() {
      _entered += d;
      _error = null;
    });
    if (_entered.length == 6) {
      if (!_confirming) {
        setState(() {
          _first = _entered;
          _entered = '';
          _confirming = true;
        });
      } else if (_entered == _first) {
        _save();
      } else {
        setState(() {
          _error = 'PINs did not match. Try again.';
          _entered = '';
          _confirming = false;
          _first = '';
        });
      }
    }
  }

  Future<void> _save() async {
    final userId = ref.read(authStateProvider).value?.uid ?? '';
    await ref.read(pinRepositoryProvider).setPin(userId, _first);
    ref.invalidate(pinConfigProvider);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppSpacing.lg)),
      child: SingleChildScrollView(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_confirming ? 'Confirm your PIN' : 'Set a 6-digit PIN', style: AppTypography.titleMedium(onBg)),
          const SizedBox(height: AppSpacing.md),
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
              );
            }),
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(_error!, style: TextStyle(color: AppColors.error)),
          ],
          const SizedBox(height: AppSpacing.lg),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1.8,
            children: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '⌫'].map((k) {
              if (k.isEmpty) return const SizedBox.shrink();
              return TextButton(
                onPressed: () => k == '⌫'
                    ? setState(() => _entered = _entered.isEmpty ? _entered : _entered.substring(0, _entered.length - 1))
                    : _onDigit(k),
                child: Text(k, style: TextStyle(fontSize: 20, color: onBg)),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.sm),
          Consumer(builder: (context, ref, _) {
            return TextButton.icon(
              icon: Icon(Icons.fingerprint, color: gold),
              label: Text('Enable biometric unlock', style: TextStyle(color: gold)),
              onPressed: () async {
                final auth = LocalAuthentication();
                final canCheck = await auth.canCheckBiometrics && await auth.isDeviceSupported();
                if (!canCheck) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No biometric hardware available on this device.')),
                    );
                  }
                  return;
                }
                final userId = ref.read(authStateProvider).value?.uid ?? '';
                await ref.read(pinRepositoryProvider).setBiometricEnabled(userId, true);
                ref.invalidate(pinConfigProvider);
              },
            );
          }),
        ],
        ),
      ),
    );
  }
}
