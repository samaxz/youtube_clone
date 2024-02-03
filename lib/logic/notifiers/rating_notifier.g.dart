// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ratingNotifierHash() => r'df68f46f97f7797ba4e77e30f9f23239bf42a07f';

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

abstract class _$RatingNotifier
    extends BuildlessAutoDisposeNotifier<AsyncValue<RatingState>> {
  late final String videoId;

  AsyncValue<RatingState> build(
    String videoId,
  );
}

/// See also [RatingNotifier].
@ProviderFor(RatingNotifier)
const ratingNotifierProvider = RatingNotifierFamily();

/// See also [RatingNotifier].
class RatingNotifierFamily extends Family<AsyncValue<RatingState>> {
  /// See also [RatingNotifier].
  const RatingNotifierFamily();

  /// See also [RatingNotifier].
  RatingNotifierProvider call(
    String videoId,
  ) {
    return RatingNotifierProvider(
      videoId,
    );
  }

  @override
  RatingNotifierProvider getProviderOverride(
    covariant RatingNotifierProvider provider,
  ) {
    return call(
      provider.videoId,
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
  String? get name => r'ratingNotifierProvider';
}

/// See also [RatingNotifier].
class RatingNotifierProvider extends AutoDisposeNotifierProviderImpl<
    RatingNotifier, AsyncValue<RatingState>> {
  /// See also [RatingNotifier].
  RatingNotifierProvider(
    String videoId,
  ) : this._internal(
          () => RatingNotifier()..videoId = videoId,
          from: ratingNotifierProvider,
          name: r'ratingNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ratingNotifierHash,
          dependencies: RatingNotifierFamily._dependencies,
          allTransitiveDependencies:
              RatingNotifierFamily._allTransitiveDependencies,
          videoId: videoId,
        );

  RatingNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.videoId,
  }) : super.internal();

  final String videoId;

  @override
  AsyncValue<RatingState> runNotifierBuild(
    covariant RatingNotifier notifier,
  ) {
    return notifier.build(
      videoId,
    );
  }

  @override
  Override overrideWith(RatingNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: RatingNotifierProvider._internal(
        () => create()..videoId = videoId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        videoId: videoId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<RatingNotifier, AsyncValue<RatingState>>
      createElement() {
    return _RatingNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RatingNotifierProvider && other.videoId == videoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, videoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RatingNotifierRef
    on AutoDisposeNotifierProviderRef<AsyncValue<RatingState>> {
  /// The parameter `videoId` of this provider.
  String get videoId;
}

class _RatingNotifierProviderElement extends AutoDisposeNotifierProviderElement<
    RatingNotifier, AsyncValue<RatingState>> with RatingNotifierRef {
  _RatingNotifierProviderElement(super.provider);

  @override
  String get videoId => (origin as RatingNotifierProvider).videoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
