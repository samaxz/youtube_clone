// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shorts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shortsNotifierHash() => r'c8fabd335646f7279b7d077b379fb98846c3f85b';

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

abstract class _$ShortsNotifier
    extends BuildlessAutoDisposeNotifier<List<BaseInfoState<Video>>> {
  late final int screenIndex;

  List<BaseInfoState<Video>> build(
    int screenIndex,
  );
}

/// See also [ShortsNotifier].
@ProviderFor(ShortsNotifier)
const shortsNotifierProvider = ShortsNotifierFamily();

/// See also [ShortsNotifier].
class ShortsNotifierFamily extends Family<List<BaseInfoState<Video>>> {
  /// See also [ShortsNotifier].
  const ShortsNotifierFamily();

  /// See also [ShortsNotifier].
  ShortsNotifierProvider call(
    int screenIndex,
  ) {
    return ShortsNotifierProvider(
      screenIndex,
    );
  }

  @override
  ShortsNotifierProvider getProviderOverride(
    covariant ShortsNotifierProvider provider,
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
  String? get name => r'shortsNotifierProvider';
}

/// See also [ShortsNotifier].
class ShortsNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ShortsNotifier, List<BaseInfoState<Video>>> {
  /// See also [ShortsNotifier].
  ShortsNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => ShortsNotifier()..screenIndex = screenIndex,
          from: shortsNotifierProvider,
          name: r'shortsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$shortsNotifierHash,
          dependencies: ShortsNotifierFamily._dependencies,
          allTransitiveDependencies:
              ShortsNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  ShortsNotifierProvider._internal(
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
  List<BaseInfoState<Video>> runNotifierBuild(
    covariant ShortsNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(ShortsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ShortsNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ShortsNotifier, List<BaseInfoState<Video>>>
      createElement() {
    return _ShortsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShortsNotifierProvider && other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ShortsNotifierRef
    on AutoDisposeNotifierProviderRef<List<BaseInfoState<Video>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ShortsNotifierProviderElement extends AutoDisposeNotifierProviderElement<
    ShortsNotifier, List<BaseInfoState<Video>>> with ShortsNotifierRef {
  _ShortsNotifierProviderElement(super.provider);

  @override
  int get screenIndex => (origin as ShortsNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
