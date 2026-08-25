import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/social/data/models/partner_model.dart';
import 'package:hybrid_tracker/features/social/domain/providers/social_providers.dart';

class AccountabilityScreen extends ConsumerWidget {
  const AccountabilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final partnersAsync = ref.watch(myPartnersProvider);
    final checkInsAsync = ref.watch(recentCheckInsProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Accountability', style: AppTypography.titleLarge(onBg)),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add_alt_1_outlined, color: gold),
            onPressed: () => _showInviteSheet(context, ref),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(myPartnersProvider);
          ref.invalidate(recentCheckInsProvider);
        },
        child: partnersAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Text('Could not load partners.\nCheck your connection.',
                textAlign: TextAlign.center, style: AppTypography.bodyMedium(muted)),
          ),
          data: (partners) {
            if (partners.isEmpty) {
              return _EmptyState(gold: gold, muted: muted, onBg: onBg, ref: ref);
            }
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                ...partners.asMap().entries.map((entry) {
                  final i = entry.key;
                  final p = entry.value;
                  return _PartnerCard(partner: p, surface: surface, onBg: onBg, muted: muted, gold: gold)
                      .animate(delay: (i * 60).ms)
                      .fadeIn(duration: 250.ms)
                      .slideY(begin: 0.15, end: 0);
                }),
                const SizedBox(height: AppSpacing.lg),
                Text('Recent Check-ins', style: AppTypography.titleMedium(onBg)),
                const SizedBox(height: AppSpacing.sm),
                checkInsAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (checkIns) => checkIns.isEmpty
                      ? Text('No check-ins yet.', style: AppTypography.bodySmall(muted))
                      : Column(
                          children: checkIns
                              .map((c) => ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(Icons.check_circle_outline, color: gold),
                                    title: Text(c.note ?? 'Checked in', style: AppTypography.bodyMedium(onBg)),
                                    subtitle: Text(_relativeTime(c.createdAt), style: AppTypography.bodySmall(muted)),
                                  ))
                              .toList(),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showInviteSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _InviteSheet(),
    );
  }

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

class _EmptyState extends ConsumerWidget {
  const _EmptyState({required this.gold, required this.muted, required this.onBg, required this.ref});
  final Color gold, muted, onBg;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef _) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 56, color: muted).animate().scale(duration: 250.ms).fadeIn(),
          const SizedBox(height: AppSpacing.md),
          Text('No accountability partners yet', style: AppTypography.titleMedium(onBg))
              .animate(delay: 100.ms)
              .fadeIn(duration: 250.ms),
          const SizedBox(height: AppSpacing.xs),
          Text('Invite a friend or enter their code', style: AppTypography.bodySmall(muted))
              .animate(delay: 150.ms)
              .fadeIn(duration: 250.ms),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: gold),
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => _InviteSheet(),
            ),
            child: const Text('Get Started'),
          ).animate(delay: 200.ms).fadeIn(duration: 250.ms),
        ],
      ),
    );
  }
}

class _PartnerCard extends StatelessWidget {
  const _PartnerCard({
    required this.partner,
    required this.surface,
    required this.onBg,
    required this.muted,
    required this.gold,
  });

  final PartnerModel partner;
  final Color surface, onBg, muted, gold;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: gold.withValues(alpha: 0.2), child: Icon(Icons.person, color: gold)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  partner.partnerDisplayName,
                  style: AppTypography.bodyMedium(onBg),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${partner.partnerStreak}-day streak · ${partner.partnerHabitsToday} habits today',
                  style: AppTypography.bodySmall(muted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Consumer(builder: (context, ref, _) {
            return IconButton(
              icon: Icon(Icons.waving_hand_outlined, color: gold),
              tooltip: 'Check in',
              onPressed: () async {
                await ref.read(socialActionsProvider.notifier).checkIn(partner.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Checked in!')),
                  );
                }
              },
            );
          }),
        ],
      ),
    );
  }
}

class _InviteSheet extends ConsumerStatefulWidget {
  @override
  ConsumerState<_InviteSheet> createState() => _InviteSheetState();
}

class _InviteSheetState extends ConsumerState<_InviteSheet> {
  final _codeController = TextEditingController();
  String? _generatedCode;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: Container(
        decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppSpacing.lg)),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invite a Partner', style: AppTypography.titleMedium(onBg)),
            const SizedBox(height: AppSpacing.md),
            if (_generatedCode == null)
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: gold),
                onPressed: _loading
                    ? null
                    : () async {
                        setState(() => _loading = true);
                        final code = await ref.read(socialActionsProvider.notifier).createInvite();
                        setState(() {
                          _generatedCode = code;
                          _loading = false;
                        });
                      },
                child: _loading
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Generate Invite Code'),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Share this code:', style: AppTypography.bodySmall(muted)),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Text(_generatedCode!, style: AppTypography.titleLarge(gold)),
                      const SizedBox(width: AppSpacing.sm),
                      IconButton(
                        icon: Icon(Icons.share_outlined, color: gold),
                        onPressed: () => Share.share('Join me on Ryve! Use my code: $_generatedCode'),
                      ),
                    ],
                  ),
                ],
              ),
            const Divider(height: AppSpacing.xl),
            Text('Have a code?', style: AppTypography.bodySmall(muted)),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _codeController,
                    textCapitalization: TextCapitalization.characters,
                    style: TextStyle(color: onBg),
                    decoration: const InputDecoration(hintText: 'Enter code'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: gold),
                  onPressed: () async {
                    if (_codeController.text.trim().isEmpty) return;
                    try {
                      await ref.read(socialActionsProvider.notifier).redeemInvite(_codeController.text);
                      if (context.mounted) Navigator.of(context).pop();
                    } catch (e) {
                      setState(() => _error = e.toString());
                    }
                  },
                  child: const Text('Join'),
                ),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(_error!, style: TextStyle(color: AppColors.error, fontSize: 12)),
            ],
          ],
        ),
      ),
    );
  }
}
