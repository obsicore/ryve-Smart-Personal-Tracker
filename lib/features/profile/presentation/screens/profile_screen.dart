import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hybrid_tracker/core/router/app_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/theme_provider.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/profile/data/models/profile_model.dart';
import 'package:hybrid_tracker/features/profile/domain/providers/profile_providers.dart';
import 'package:hybrid_tracker/features/profile/presentation/widgets/badge_card.dart';
import 'package:hybrid_tracker/features/profile/presentation/widgets/streak_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _xpController;
  late Animation<double> _xpAnimation;

  @override
  void initState() {
    super.initState();
    _xpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _xpAnimation = CurvedAnimation(
      parent: _xpController,
      curve: Curves.easeOut,
    );
    // Defer start so the tree is built first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _xpController.forward();
    });
  }

  @override
  void dispose() {
    _xpController.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    await ref.read(authNotifierProvider.notifier).signOut();
    if (!mounted) return;
    context.go(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    final profileAsync = ref.watch(userProfileProvider);
    final badgesAsync = ref.watch(userBadgesProvider);
    final themeMode = ref.watch(themeModeProvider);

    final bgColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceVariant =
        isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;
    final textColor =
        isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final onSurface =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final goldColor =
        isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final greenColor =
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    return Scaffold(
      backgroundColor: bgColor,
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Failed to load profile',
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ),
        data: (profile) => SafeArea(
          child: CustomScrollView(
            slivers: [
              // ── App Bar ──────────────────────────────────────────────────
              SliverAppBar(
                backgroundColor: bgColor,
                pinned: false,
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: Icon(Icons.settings_outlined, color: mutedColor),
                    onPressed: () {},
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Header ──────────────────────────────────────────
                      _buildHeader(
                        context,
                        profile: profile,
                        isDark: isDark,
                        disableAnimations: disableAnimations,
                        bgColor: bgColor,
                        textColor: textColor,
                        mutedColor: mutedColor,
                        goldColor: goldColor,
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      // ── XP Bar ──────────────────────────────────────────
                      _buildXpBar(
                        context,
                        profile: profile,
                        disableAnimations: disableAnimations,
                        textColor: textColor,
                        mutedColor: mutedColor,
                        goldColor: goldColor,
                        greenColor: greenColor,
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      // ── Stats Row ────────────────────────────────────────
                      _buildStatsRow(
                        context,
                        profile: profile,
                        isDark: isDark,
                        disableAnimations: disableAnimations,
                        surfaceVariant: surfaceVariant,
                        onSurface: onSurface,
                        mutedColor: mutedColor,
                        goldColor: goldColor,
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      // ── Streak ───────────────────────────────────────────
                      StreakWidget(
                        currentStreak: profile.currentStreak,
                        bestStreak: profile.bestStreak,
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      // ── Badges ───────────────────────────────────────────
                      _buildBadgesSection(
                        context,
                        badgesAsync: badgesAsync,
                        isDark: isDark,
                        disableAnimations: disableAnimations,
                        textColor: textColor,
                        mutedColor: mutedColor,
                        goldColor: goldColor,
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      // ── Settings ─────────────────────────────────────────
                      _buildSettings(
                        context,
                        isDark: isDark,
                        disableAnimations: disableAnimations,
                        surfaceColor: surfaceColor,
                        onSurface: onSurface,
                        mutedColor: mutedColor,
                        goldColor: goldColor,
                        themeMode: themeMode,
                      ),

                      const SizedBox(height: AppSpacing.x4l),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(
    BuildContext context, {
    required ProfileModel profile,
    required bool isDark,
    required bool disableAnimations,
    required Color bgColor,
    required Color textColor,
    required Color mutedColor,
    required Color goldColor,
  }) {
    Widget avatar = _AvatarWidget(
      avatarUrl: profile.avatarUrl,
      displayName: profile.displayName,
      isDark: isDark,
      bgColor: bgColor,
      goldColor: goldColor,
    );

    if (!disableAnimations) {
      avatar = avatar
          .animate()
          .scale(
            begin: const Offset(0.6, 0.6),
            end: const Offset(1, 1),
            duration: 350.ms,
            curve: Curves.elasticOut,
          )
          .fadeIn(duration: 200.ms);
    }

    Widget nameText = Text(
      profile.displayName,
      style: TextStyle(
        color: textColor,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );

    Widget levelChip = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: goldColor, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        'Lv. ${profile.level}',
        style: TextStyle(
          color: goldColor,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );

    if (!disableAnimations) {
      nameText = nameText
          .animate(delay: 60.ms)
          .fadeIn(duration: 280.ms)
          .slideY(begin: 0.2, end: 0);
      levelChip = levelChip
          .animate(delay: 100.ms)
          .fadeIn(duration: 280.ms)
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
    }

    return Column(
      children: [
        avatar,
        const SizedBox(height: AppSpacing.md),
        nameText,
        if (profile.email != null) ...[
          const SizedBox(height: AppSpacing.xs),
          _maybeAnimate(
            Text(
              profile.email!,
              style: TextStyle(color: mutedColor, fontSize: 13),
            ),
            disabled: disableAnimations,
            delay: 80.ms,
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        levelChip,
      ],
    );
  }

  // ── XP Bar ────────────────────────────────────────────────────────────────

  Widget _buildXpBar(
    BuildContext context, {
    required ProfileModel profile,
    required bool disableAnimations,
    required Color textColor,
    required Color mutedColor,
    required Color goldColor,
    required Color greenColor,
  }) {
    final progress =
        profile.xpToNextLevel == 0 ? 1.0 : profile.xpTotal / profile.xpToNextLevel;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Level ${profile.level}',
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${profile.xpTotal} / ${profile.xpToNextLevel} XP',
              style: TextStyle(color: mutedColor, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.full),
          child: Container(
            height: 8,
            color: mutedColor.withValues(alpha: 0.2),
            child: disableAnimations
                ? _XpFill(
                    progress: progress,
                    greenColor: greenColor,
                    goldColor: goldColor,
                  )
                : AnimatedBuilder(
                    animation: _xpAnimation,
                    builder: (context, _) => _XpFill(
                      progress: progress * _xpAnimation.value,
                      greenColor: greenColor,
                      goldColor: goldColor,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  // ── Stats Row ─────────────────────────────────────────────────────────────

  Widget _buildStatsRow(
    BuildContext context, {
    required ProfileModel profile,
    required bool isDark,
    required bool disableAnimations,
    required Color surfaceVariant,
    required Color onSurface,
    required Color mutedColor,
    required Color goldColor,
  }) {
    final stats = [
      _StatItem(value: '${profile.tasksCompleted}', label: 'Tasks'),
      _StatItem(value: '${profile.habitsLogged}', label: 'Habits'),
      _StatItem(value: '${profile.focusHours}h', label: 'Focus'),
    ];

    final children = <Widget>[];
    for (var i = 0; i < stats.length; i++) {
      Widget card = _StatCard(
        stat: stats[i],
        surfaceVariant: surfaceVariant,
        onSurface: onSurface,
        mutedColor: mutedColor,
        goldColor: goldColor,
        isDark: isDark,
      );

      if (!disableAnimations) {
        card = card
            .animate(delay: Duration(milliseconds: 80 + i * 30))
            .fadeIn(duration: 280.ms)
            .slideY(begin: 0.25, end: 0);
      }

      children.add(Expanded(child: card));
      if (i < stats.length - 1) {
        children.add(const SizedBox(width: AppSpacing.sm));
      }
    }

    return Row(children: children);
  }

  // ── Badges ────────────────────────────────────────────────────────────────

  Widget _buildBadgesSection(
    BuildContext context, {
    required AsyncValue<List<BadgeModel>> badgesAsync,
    required bool isDark,
    required bool disableAnimations,
    required Color textColor,
    required Color mutedColor,
    required Color goldColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Achievements',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            badgesAsync.when(
              data: (badges) => Text(
                '${badges.length} badges',
                style: TextStyle(color: mutedColor, fontSize: 13),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        badgesAsync.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.x3l),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (_, __) => Center(
            child: Text(
              'Could not load badges',
              style: TextStyle(color: mutedColor),
            ),
          ),
          data: (badges) => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.85,
            ),
            itemCount: badges.length,
            itemBuilder: (context, i) => BadgeCard(
              badge: badges[i],
              animationDelay: disableAnimations
                  ? Duration.zero
                  : Duration(milliseconds: i * 60),
            ),
          ),
        ),
      ],
    );
  }

  // ── Settings ──────────────────────────────────────────────────────────────

  Widget _buildSettings(
    BuildContext context, {
    required bool isDark,
    required bool disableAnimations,
    required Color surfaceColor,
    required Color onSurface,
    required Color mutedColor,
    required Color goldColor,
    required ThemeMode themeMode,
  }) {
    final themeNotifier = ref.read(themeModeProvider.notifier);

    String themeModeLabel(ThemeMode mode) {
      switch (mode) {
        case ThemeMode.system:
          return 'System';
        case ThemeMode.light:
          return 'Light';
        case ThemeMode.dark:
          return 'Dark';
      }
    }

    ThemeMode nextMode(ThemeMode mode) {
      switch (mode) {
        case ThemeMode.system:
          return ThemeMode.light;
        case ThemeMode.light:
          return ThemeMode.dark;
        case ThemeMode.dark:
          return ThemeMode.system;
      }
    }

    Widget tile({
      required IconData icon,
      required String title,
      String? subtitle,
      Widget? trailing,
      VoidCallback? onTap,
      bool isDanger = false,
    }) {
      return Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isDanger ? AppColors.error : mutedColor,
            size: 22,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isDanger ? AppColors.error : onSurface,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(color: mutedColor, fontSize: 12),
                )
              : null,
          trailing: trailing ??
              Icon(Icons.chevron_right_rounded, color: mutedColor, size: 20),
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
        ),
      );
    }

    Widget section = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: TextStyle(
            color: onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        tile(
          icon: Icons.palette_outlined,
          title: 'Appearance',
          subtitle: themeModeLabel(themeMode),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                themeModeLabel(themeMode),
                style: TextStyle(color: goldColor, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(Icons.chevron_right_rounded, color: mutedColor, size: 20),
            ],
          ),
          onTap: () => themeNotifier.setMode(nextMode(themeMode)),
        ),
        tile(
          icon: Icons.lock_outline_rounded,
          title: 'PIN Lock',
          subtitle: 'Not configured',
          trailing: Switch(
            value: false,
            onChanged: null,
            activeThumbColor: goldColor,
          ),
        ),
        tile(
          icon: Icons.download_outlined,
          title: 'Export Data',
          subtitle: 'Download your data as JSON',
          onTap: () {},
        ),
        tile(
          icon: Icons.logout_rounded,
          title: 'Sign Out',
          isDanger: true,
          trailing: const SizedBox.shrink(),
          onTap: _signOut,
        ),
      ],
    );

    if (!disableAnimations) {
      section = section
          .animate(delay: 120.ms)
          .fadeIn(duration: 300.ms)
          .slideY(begin: 0.15, end: 0);
    }

    return section;
  }
}

// ── Animation helper ──────────────────────────────────────────────────────────

Widget _maybeAnimate(
  Widget child, {
  required bool disabled,
  Duration delay = Duration.zero,
  Duration duration = const Duration(milliseconds: 280),
}) {
  if (disabled) return child;
  return child
      .animate(delay: delay)
      .fadeIn(duration: duration)
      .slideY(begin: 0.2, end: 0);
}

// ── Helper widgets ────────────────────────────────────────────────────────────

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({
    required this.avatarUrl,
    required this.displayName,
    required this.isDark,
    required this.bgColor,
    required this.goldColor,
  });

  final String? avatarUrl;
  final String displayName;
  final bool isDark;
  final Color bgColor;
  final Color goldColor;

  @override
  Widget build(BuildContext context) {
    final initials = displayName.isNotEmpty
        ? displayName.trim().split(' ').map((w) => w[0]).take(2).join().toUpperCase()
        : 'R';

    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: goldColor, width: 2.5),
      ),
      child: ClipOval(
        child: avatarUrl != null && avatarUrl!.isNotEmpty
            ? Image.network(
                avatarUrl!,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _InitialsAvatar(
                  initials: initials,
                  isDark: isDark,
                  goldColor: goldColor,
                ),
              )
            : _InitialsAvatar(
                initials: initials,
                isDark: isDark,
                goldColor: goldColor,
              ),
      ),
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  const _InitialsAvatar({
    required this.initials,
    required this.isDark,
    required this.goldColor,
  });

  final String initials;
  final bool isDark;
  final Color goldColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [AppColors.darkSurfaceVariant, AppColors.darkSurfaceBright]
              : [AppColors.lightSurfaceVariant, AppColors.lightSurfaceBright],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: goldColor,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _XpFill extends StatelessWidget {
  const _XpFill({
    required this.progress,
    required this.greenColor,
    required this.goldColor,
  });

  final double progress;
  final Color greenColor;
  final Color goldColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: constraints.maxWidth * progress.clamp(0.0, 1.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [greenColor, goldColor],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem {
  const _StatItem({required this.value, required this.label});
  final String value;
  final String label;
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.stat,
    required this.surfaceVariant,
    required this.onSurface,
    required this.mutedColor,
    required this.goldColor,
    required this.isDark,
  });

  final _StatItem stat;
  final Color surfaceVariant;
  final Color onSurface;
  final Color mutedColor;
  final Color goldColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: goldColor.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            stat.value,
            style: TextStyle(
              color: goldColor,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            stat.label,
            style: TextStyle(
              color: mutedColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
