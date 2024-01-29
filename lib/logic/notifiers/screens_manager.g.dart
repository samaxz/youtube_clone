// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screens_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$screensManagerHash() => r'421f4ed071a1930e179d10298ddf301736583264';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ScreensManager
    extends BuildlessAutoDisposeNotifier<List<CustomScreen>> {
  late final int screenIndex;

  List<CustomScreen> build(
    int screenIndex,
  );
}

/// See also [ScreensManager].
@ProviderFor(ScreensManager)
const screensManagerProvider = ScreensManagerFamily();

/// See also [ScreensManager].
class ScreensManagerFamily extends Family<List<CustomScreen>> {
  /// See also [ScreensManager].
  const ScreensManagerFamily();

  /// See also [ScreensManager].
  ScreensManagerProvider call(
    int screenIndex,
  ) {
    return ScreensManagerProvider(
      screenIndex,
    );
  }

  @override
  ScreensManagerProvider getProviderOverride(
    covariant ScreensManagerProvider provider,
  ) {
    return call(
      provider.screenIndex,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'screensManagerProvider';
}

/// See also [ScreensManager].
class ScreensManagerProvider extends AutoDisposeNotifierProviderImpl<
    ScreensManager, List<CustomScreen>> {
  /// See also [ScreensManager].
  ScreensManagerProvider(
    int screenIndex,
  ) : this._internal(
          () => ScreensManager()..screenIndex = screenIndex,
          from: screensManagerProvider,
          name: r'screensManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$screensManagerHash,
          dependencies: ScreensManagerFamily._dependencies,
          allTransitiveDependencies:
              ScreensManagerFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  ScreensManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.screenIndex,
  }) : super.internal();

  final int screenIndex;

  @override
  List<CustomScreen> runNotifierBuild(
    covariant ScreensManager notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(ScreensManager Function() create) {
    return ProviderOverride(
      origin: this,
      override: ScreensManagerProvider._internal(
        () => create()..screenIndex = screenIndex,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        screenIndex: screenIndex,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ScreensManager, List<CustomScreen>>
      createElement() {
    return _ScreensManagerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScreensManagerProvider && other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ScreensManagerRef on AutoDisposeNotifierProviderRef<List<CustomScreen>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ScreensManagerProviderElement extends AutoDisposeNotifierProviderElement<
    ScreensManager, List<CustomScreen>> with ScreensManagerRef {
  _ScreensManagerProviderElement(super.provider);

  @override
  int get screenIndex => (origin as ScreensManagerProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
