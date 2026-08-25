import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/utils/hex_color.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/customization/data/repositories/customization_repository.dart';
import 'package:hybrid_tracker/main.dart' show databaseProvider;

part 'customization_providers.g.dart';

final customizationRepositoryProvider = Provider<CustomizationRepository>((ref) {
  return CustomizationRepository(ref.watch(databaseProvider));
});

String _uid(Ref ref) => ref.watch(authStateProvider).value?.uid ?? '';

@riverpod
Future<List<AppThemeRecord>> appThemes(Ref ref) async {
  final repo = ref.watch(customizationRepositoryProvider);
  await repo.seedThemesIfEmpty();
  return repo.allThemes();
}

@riverpod
Future<String?> activeThemeId(Ref ref) {
  return ref.watch(customizationRepositoryProvider).activeThemeId(_uid(ref));
}

/// Resolves the active `app_themes` row (if any) into the [ThemeColorSet]
/// `AppColors.applyTheme` understands. Null means "no custom theme picked,
/// use the built-in defaults" — the picker starts unset for every user.
@riverpod
Future<ThemeColorSet?> resolvedActiveTheme(Ref ref) async {
  final id = await ref.watch(activeThemeIdProvider.future);
  if (id == null) return null;
  final themes = await ref.watch(appThemesProvider.future);
  AppThemeRecord? record;
  for (final t in themes) {
    if (t.id == id) {
      record = t;
      break;
    }
  }
  if (record == null) return null;
  return ThemeColorSet(
    id: record.id,
    primary: colorFromHex(record.primaryHex),
    accent: colorFromHex(record.accentHex),
    background: colorFromHex(record.backgroundHex),
    surface: colorFromHex(record.surfaceHex),
    isDark: record.isDark,
  );
}

@riverpod
Future<List<DashboardCard>> dashboardCardsConfig(Ref ref) {
  return ref.watch(customizationRepositoryProvider).dashboardCards(_uid(ref));
}

@riverpod
Future<List<WidgetConfig>> widgetConfigs(Ref ref) {
  return ref.watch(customizationRepositoryProvider).widgetConfigs(_uid(ref));
}

@riverpod
class CustomizationActions extends _$CustomizationActions {
  @override
  void build() {}

  Future<void> selectTheme(String themeId) async {
    await ref.read(customizationRepositoryProvider).setActiveTheme(_uid(ref), themeId);
    ref.invalidate(activeThemeIdProvider);
  }

  Future<void> reorder(List<DashboardCard> cards) async {
    await ref.read(customizationRepositoryProvider).reorderDashboardCards(cards);
    ref.invalidate(dashboardCardsConfigProvider);
  }

  Future<void> toggleCard(String cardId, bool visible) async {
    await ref.read(customizationRepositoryProvider).toggleCardVisibility(cardId, visible);
    ref.invalidate(dashboardCardsConfigProvider);
  }

  Future<void> toggleWidget(String id, bool enabled) async {
    await ref.read(customizationRepositoryProvider).toggleWidget(id, enabled);
    ref.invalidate(widgetConfigsProvider);
  }
}
