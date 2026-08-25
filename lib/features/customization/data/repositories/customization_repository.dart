import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';

const _uuid = Uuid();

const seedThemes = [
  (id: 'forest-dark', name: 'Forest Dark', primary: '#C9A84C', accent: '#4CAF82', bg: '#0D1F17', surface: '#152B1E', dark: true),
  (id: 'ocean-dark', name: 'Ocean Dark', primary: '#5EC8D8', accent: '#8AD6C2', bg: '#0B1A22', surface: '#12262F', dark: true),
  (id: 'desert-light', name: 'Desert Light', primary: '#C97A4C', accent: '#D8A85E', bg: '#FBF3E7', surface: '#FFFFFF', dark: false),
  (id: 'minimal-light', name: 'Minimal Light', primary: '#2A3C32', accent: '#6B8275', bg: '#FAFAF8', surface: '#FFFFFF', dark: false),
  (id: 'amoled-black', name: 'Amoled Black', primary: '#E8C46A', accent: '#4CAF82', bg: '#000000', surface: '#0A0A0A', dark: true),
];

class CustomizationRepository {
  CustomizationRepository(this._db);

  final AppDatabase _db;

  Future<void> seedThemesIfEmpty() async {
    final existing = await _db.select(_db.appThemes).get();
    if (existing.isNotEmpty) return;
    for (final t in seedThemes) {
      await _db.into(_db.appThemes).insert(AppThemesCompanion.insert(
            id: t.id,
            name: t.name,
            primaryHex: t.primary,
            accentHex: t.accent,
            backgroundHex: t.bg,
            surfaceHex: t.surface,
            isDark: Value(t.dark),
          ));
    }
  }

  Future<List<AppThemeRecord>> allThemes() => _db.select(_db.appThemes).get();

  Future<void> setActiveTheme(String userId, String themeId) async {
    final profile = await (_db.select(_db.userProfiles)..where((t) => t.userId.equals(userId))).getSingleOrNull();
    if (profile == null) return;
    await (_db.update(_db.userProfiles)..where((t) => t.id.equals(profile.id)))
        .write(UserProfilesCompanion(activeThemeId: Value(themeId)));
  }

  Future<String?> activeThemeId(String userId) async {
    final profile = await (_db.select(_db.userProfiles)..where((t) => t.userId.equals(userId))).getSingleOrNull();
    return profile?.activeThemeId;
  }

  Future<List<DashboardCard>> dashboardCards(String userId) async {
    final layout = await (_db.select(_db.dashboardLayouts)..where((t) => t.userId.equals(userId))).getSingleOrNull();
    if (layout == null) return [];
    return (_db.select(_db.dashboardCards)
          ..where((t) => t.layoutId.equals(layout.id))
          ..orderBy([(t) => OrderingTerm.asc(t.position)]))
        .get();
  }

  Future<void> reorderDashboardCards(List<DashboardCard> cards) async {
    for (var i = 0; i < cards.length; i++) {
      await (_db.update(_db.dashboardCards)..where((t) => t.id.equals(cards[i].id)))
          .write(DashboardCardsCompanion(position: Value(i)));
    }
  }

  Future<void> toggleCardVisibility(String cardId, bool isVisible) async {
    await (_db.update(_db.dashboardCards)..where((t) => t.id.equals(cardId)))
        .write(DashboardCardsCompanion(isVisible: Value(isVisible)));
  }

  Future<List<WidgetConfig>> widgetConfigs(String userId) async {
    final existing = await (_db.select(_db.widgetConfigs)..where((t) => t.userId.equals(userId))).get();
    if (existing.isNotEmpty) return existing;
    const defaults = ['habit_progress', 'focus_quick_start', 'water_tracker'];
    for (final type in defaults) {
      await _db.into(_db.widgetConfigs).insert(WidgetConfigsCompanion.insert(
            id: _uuid.v4(),
            userId: userId,
            widgetType: type,
          ));
    }
    return (_db.select(_db.widgetConfigs)..where((t) => t.userId.equals(userId))).get();
  }

  Future<void> toggleWidget(String id, bool enabled) async {
    await (_db.update(_db.widgetConfigs)..where((t) => t.id.equals(id)))
        .write(WidgetConfigsCompanion(isEnabled: Value(enabled)));
  }
}
