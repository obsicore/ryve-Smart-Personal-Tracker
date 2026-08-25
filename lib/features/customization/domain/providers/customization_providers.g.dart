// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customization_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appThemesHash() => r'c24c0b52aed02568d0d39c60f6fb1840eba728ad';

/// See also [appThemes].
@ProviderFor(appThemes)
final appThemesProvider =
    AutoDisposeFutureProvider<List<AppThemeRecord>>.internal(
  appThemes,
  name: r'appThemesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appThemesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppThemesRef = AutoDisposeFutureProviderRef<List<AppThemeRecord>>;
String _$activeThemeIdHash() => r'af7402bd423965d24807f9b981000fb68daacef3';

/// See also [activeThemeId].
@ProviderFor(activeThemeId)
final activeThemeIdProvider = AutoDisposeFutureProvider<String?>.internal(
  activeThemeId,
  name: r'activeThemeIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeThemeIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveThemeIdRef = AutoDisposeFutureProviderRef<String?>;
String _$resolvedActiveThemeHash() =>
    r'bb86d5d765446bff41619a851f3d88f5f9c27867';

/// Resolves the active `app_themes` row (if any) into the [ThemeColorSet]
/// `AppColors.applyTheme` understands. Null means "no custom theme picked,
/// use the built-in defaults" — the picker starts unset for every user.
///
/// Copied from [resolvedActiveTheme].
@ProviderFor(resolvedActiveTheme)
final resolvedActiveThemeProvider =
    AutoDisposeFutureProvider<ThemeColorSet?>.internal(
  resolvedActiveTheme,
  name: r'resolvedActiveThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resolvedActiveThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ResolvedActiveThemeRef = AutoDisposeFutureProviderRef<ThemeColorSet?>;
String _$dashboardCardsConfigHash() =>
    r'ec7d26dcce8b860fc16dc51055cdc5362162d7b1';

/// See also [dashboardCardsConfig].
@ProviderFor(dashboardCardsConfig)
final dashboardCardsConfigProvider =
    AutoDisposeFutureProvider<List<DashboardCard>>.internal(
  dashboardCardsConfig,
  name: r'dashboardCardsConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardCardsConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DashboardCardsConfigRef
    = AutoDisposeFutureProviderRef<List<DashboardCard>>;
String _$widgetConfigsHash() => r'4fbc1beef5abfb8cc573b2ac787a120a568a2f42';

/// See also [widgetConfigs].
@ProviderFor(widgetConfigs)
final widgetConfigsProvider =
    AutoDisposeFutureProvider<List<WidgetConfig>>.internal(
  widgetConfigs,
  name: r'widgetConfigsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$widgetConfigsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WidgetConfigsRef = AutoDisposeFutureProviderRef<List<WidgetConfig>>;
String _$customizationActionsHash() =>
    r'2586bff0f03755e60056f66a703fa2235015c766';

/// See also [CustomizationActions].
@ProviderFor(CustomizationActions)
final customizationActionsProvider =
    AutoDisposeNotifierProvider<CustomizationActions, void>.internal(
  CustomizationActions.new,
  name: r'customizationActionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customizationActionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomizationActions = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
