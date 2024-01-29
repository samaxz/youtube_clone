// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shorts_rating_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shortsRatingNotifierHash() =>
    r'80374755cc389bcf58aba00280b28014010e09f8';

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

abstract class _$ShortsRatingNotifier
    extends BuildlessAutoDisposeNotifier<List<AsyncValue<RatingState>>> {
  late final String videoId;
  late final int screenIndex;

  List<AsyncValue<RatingState>> build({
    required String videoId,
    required int screenIndex,
  });
}

/// See also [ShortsRatingNotifier].
@ProviderFor(ShortsRatingNotifier)
const shortsRatingNotifierProvider = ShortsRatingNotifierFamily();

/// See also [ShortsRatingNotifier].
class ShortsRatingNotifierFamily extends Family<List<AsyncValue<RatingState>>> {
  /// See also [ShortsRatingNotifier].
  const ShortsRatingNotifierFamily();

  /// See also [ShortsRatingNotifier].
  ShortsRatingNotifierProvider call({
    required String videoId,
    required int screenIndex,
  }) {
    return ShortsRatingNotifierProvider(
      videoId: videoId,
      screenIndex: screenIndex,
    );
  }

  @override
  ShortsRatingNotifierProvider getProviderOverride(
    covariant ShortsRatingNotifierProvider provider,
  ) {
    return call(
      videoId: provider.videoId,
      screenIndex: provider.screenIndex,
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
  String? get name => r'shortsRatingNotifierProvider';
}

/// See also [ShortsRatingNotifier].
class ShortsRatingNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ShortsRatingNotifier, List<AsyncValue<RatingState>>> {
  /// See also [ShortsRatingNotifier].
  ShortsRatingNotifierProvider({
    required String videoId,
    required int screenIndex,
  }) : this._internal(
          () => ShortsRatingNotifier()
            ..videoId = videoId
            ..screenIndex = screenIndex,
          from: shortsRatingNotifierProvider,
          name: r'shortsRatingNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$shortsRatingNotifierHash,
          dependencies: ShortsRatingNotifierFamily._dependencies,
          allTransitiveDependencies:
              ShortsRatingNotifierFamily._allTransitiveDependencies,
          videoId: videoId,
          screenIndex: screenIndex,
        );

  ShortsRatingNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.videoId,
    required this.screenIndex,
  }) : super.internal();

  final String videoId;
  final int screenIndex;

  @override
  List<AsyncValue<RatingState>> runNotifierBuild(
    covariant ShortsRatingNotifier notifier,
  ) {
    return notifier.build(
      videoId: videoId,
      screenIndex: screenIndex,
    );
  }

  @override
  Override overrideWith(ShortsRatingNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ShortsRatingNotifierProvider._internal(
        () => create()
          ..videoId = videoId
          ..screenIndex = screenIndex,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        videoId: videoId,
        screenIndex: screenIndex,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ShortsRatingNotifier,
      List<AsyncValue<RatingState>>> createElement() {
    return _ShortsRatingNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShortsRatingNotifierProvider &&
        other.videoId == videoId &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, videoId.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ShortsRatingNotifierRef
    on AutoDisposeNotifierProviderRef<List<AsyncValue<RatingState>>> {
  /// The parameter `videoId` of this provider.
  String get videoId;

  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ShortsRatingNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ShortsRatingNotifier,
        List<AsyncValue<RatingState>>> with ShortsRatingNotifierRef {
  _ShortsRatingNotifierProviderElement(super.provider);

  @override
  String get videoId => (origin as ShortsRatingNotifierProvider).videoId;
  @override
  int get screenIndex => (origin as ShortsRatingNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
