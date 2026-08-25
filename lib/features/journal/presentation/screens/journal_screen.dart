import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/router/app_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/journal/data/models/gratitude_log_model.dart';
import 'package:hybrid_tracker/features/journal/data/models/journal_entry_model.dart';
import 'package:hybrid_tracker/features/journal/data/models/reflection_prompt_model.dart';
import 'package:hybrid_tracker/features/journal/domain/providers/journal_providers.dart';
import 'package:hybrid_tracker/shared/widgets/empty_state_widget.dart';
import 'package:hybrid_tracker/shared/widgets/skeleton_widget.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  String _search = '';

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() => _search = value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final disableAnims = MediaQuery.of(context).disableAnimations;

    final entriesAsync = ref.watch(
      journalEntriesProvider(search: _search.isEmpty ? null : _search),
    );

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Journal', style: AppTypography.titleLarge(onBg)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: primary),
            tooltip: 'New entry',
            onPressed: () => context.push(Routes.journalNew),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            style: AppTypography.bodyMedium(onBg),
            decoration: InputDecoration(
              hintText: 'Search entries…',
              hintStyle: AppTypography.bodyMedium(muted),
              prefixIcon: Icon(Icons.search, color: muted),
              filled: true,
              fillColor: surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const _GratitudeCard(),
          const SizedBox(height: AppSpacing.lg),
          const _ReflectionPromptCard(),
          const SizedBox(height: AppSpacing.xxl),
          Text('Entries', style: AppTypography.titleMedium(onBg)),
          const SizedBox(height: AppSpacing.md),
          entriesAsync.when(
            loading: () => Column(
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: SkeletonWidget(width: double.infinity, height: 76),
                ),
              ),
            ),
            error: (_, __) => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
              child: Center(
                child: Text('Could not load journal entries', style: AppTypography.bodyMedium(muted)),
              ),
            ),
            data: (entries) {
              if (entries.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
                  child: EmptyStateWidget(
                    svgAssetPath: 'assets/illustrations/journal_empty.svg',
                    title: 'Start your first entry',
                    subtitle: 'Capture your thoughts, wins, and reflections.',
                    ctaLabel: 'Write Entry',
                    onCta: () => context.push(Routes.journalNew),
                  ),
                );
              }
              final groups = _groupByDate(entries);
              final children = <Widget>[];
              var index = 0;
              for (final group in groups.entries) {
                children.add(Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
                  child: Text(group.key, style: AppTypography.labelMedium(muted)),
                ));
                for (final entry in group.value) {
                  Widget card = _JournalEntryCard(entry: entry);
                  if (!disableAnims) {
                    card = card
                        .animate(delay: Duration(milliseconds: index * 30))
                        .fadeIn(duration: 250.ms)
                        .slideY(begin: 0.05, end: 0);
                  }
                  children.add(Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: card,
                  ));
                  index++;
                }
              }
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
            },
          ),
          const SizedBox(height: AppSpacing.x4l),
        ],
      ),
    );
  }

  Map<String, List<JournalEntryModel>> _groupByDate(List<JournalEntryModel> entries) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final weekAgo = today.subtract(const Duration(days: 7));

    final groups = <String, List<JournalEntryModel>>{
      'Today': [],
      'Yesterday': [],
      'This Week': [],
      'Older': [],
    };

    for (final entry in entries) {
      final d = DateTime(entry.entryDate.year, entry.entryDate.month, entry.entryDate.day);
      if (d == today) {
        groups['Today']!.add(entry);
      } else if (d == yesterday) {
        groups['Yesterday']!.add(entry);
      } else if (d.isAfter(weekAgo)) {
        groups['This Week']!.add(entry);
      } else {
        groups['Older']!.add(entry);
      }
    }
    groups.removeWhere((_, v) => v.isEmpty);
    return groups;
  }
}

class _GratitudeCard extends ConsumerStatefulWidget {
  const _GratitudeCard();

  @override
  ConsumerState<_GratitudeCard> createState() => _GratitudeCardState();
}

class _GratitudeCardState extends ConsumerState<_GratitudeCard> {
  final _controllers = List.generate(3, (_) => TextEditingController());
  bool _initialized = false;

  void _prefill(GratitudeLogModel? log) {
    if (_initialized || log == null) return;
    _initialized = true;
    _controllers[0].text = log.item1;
    _controllers[1].text = log.item2 ?? '';
    _controllers[2].text = log.item3 ?? '';
  }

  Future<void> _save() async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    if (_controllers[0].text.trim().isEmpty) return;
    await ref.read(journalNotifierProvider.notifier).saveGratitude(
          GratitudeLogModel(
            id: const Uuid().v4(),
            userId: userId,
            logDate: DateTime.now(),
            item1: _controllers[0].text.trim(),
            item2: _controllers[1].text.trim().isEmpty ? null : _controllers[1].text.trim(),
            item3: _controllers[2].text.trim().isEmpty ? null : _controllers[2].text.trim(),
            createdAt: DateTime.now(),
          ),
        );
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final gratitudeAsync = ref.watch(todayGratitudeProvider);

    gratitudeAsync.whenData(_prefill);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: gold.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite, color: gold, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Text("Today's Gratitude", style: AppTypography.titleMedium(onSurface)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < 3; i++) ...[
            TextField(
              controller: _controllers[i],
              style: AppTypography.bodyMedium(onSurface),
              onSubmitted: (_) => _save(),
              onEditingComplete: _save,
              decoration: InputDecoration(
                hintText: "I'm grateful for…",
                hintStyle: AppTypography.bodySmall(onSurface.withValues(alpha: 0.4)),
                isDense: true,
                border: const UnderlineInputBorder(),
              ),
            ),
            if (i < 2) const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _ReflectionPromptCard extends ConsumerWidget {
  const _ReflectionPromptCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final promptAsync = ref.watch(todayReflectionPromptProvider);

    return promptAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (prompt) {
        final responseAsync = ref.watch(reflectionResponseForProvider(prompt.id));
        return Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reflection', style: AppTypography.labelMedium(muted)),
              const SizedBox(height: AppSpacing.xs),
              Text(prompt.content, style: AppTypography.bodyMedium(onSurface)),
              const SizedBox(height: AppSpacing.sm),
              responseAsync.maybeWhen(
                data: (r) => r != null
                    ? Text(r.response, style: AppTypography.bodySmall(muted))
                    : _ReflectionInput(promptId: prompt.id),
                orElse: () => _ReflectionInput(promptId: prompt.id),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReflectionInput extends ConsumerStatefulWidget {
  const _ReflectionInput({required this.promptId});
  final String promptId;

  @override
  ConsumerState<_ReflectionInput> createState() => _ReflectionInputState();
}

class _ReflectionInputState extends ConsumerState<_ReflectionInput> {
  final _controller = TextEditingController();

  Future<void> _save() async {
    if (_controller.text.trim().isEmpty) return;
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    await ref.read(journalNotifierProvider.notifier).saveReflectionResponse(
          ReflectionResponseModel(
            id: const Uuid().v4(),
            userId: userId,
            promptId: widget.promptId,
            response: _controller.text.trim(),
            createdAt: DateTime.now(),
          ),
        );
    ref.invalidate(reflectionResponseForProvider(widget.promptId));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    return TextField(
      controller: _controller,
      style: AppTypography.bodyMedium(onSurface),
      onSubmitted: (_) => _save(),
      onEditingComplete: _save,
      decoration: const InputDecoration(
        hintText: 'Write your answer…',
        isDense: true,
        border: UnderlineInputBorder(),
      ),
    );
  }
}

class _JournalEntryCard extends StatelessWidget {
  const _JournalEntryCard({required this.entry});
  final JournalEntryModel entry;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md),
      onTap: () => context.push('/journal/${entry.id}'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            if (entry.moodTag != null) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: gold, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.displayTitle,
                    style: AppTypography.bodyMedium(onSurface),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${DateFormat('MMM d').format(entry.entryDate)} · ${entry.wordCount} words',
                    style: AppTypography.bodySmall(muted),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: muted, size: 18),
          ],
        ),
      ),
    );
  }
}
