// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_shorts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelShortsNotifierHash() =>
    r'e9960c7953d511300ffe090a6e5266ba02a164ac';

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

abstract class _$ChannelShortsNotifier
    extends BuildlessAutoDisposeNotifier<List<AsyncValue<List<Video>>>> {
  late final int screenIndex;

  List<AsyncValue<List<Video>>> build(
    int screenIndex,
  );
}

/// See also [ChannelShortsNotifier].
@ProviderFor(ChannelShortsNotifier)
const channelShortsNotifierProvider = ChannelShortsNotifierFamily();

/// See also [ChannelShortsNotifier].
class ChannelShortsNotifierFamily
    extends Family<List<AsyncValue<List<Video>>>> {
  /// See also [ChannelShortsNotifier].
  const ChannelShortsNotifierFamily();

  /// See also [ChannelShortsNotifier].
  ChannelShortsNotifierProvider call(
    int screenIndex,
  ) {
    return ChannelShortsNotifierProvider(
      screenIndex,
    );
  }

  @override
  ChannelShortsNotifierProvider getProviderOverride(
    covariant ChannelShortsNotifierProvider provider,
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
  String? get name => r'channelShortsNotifierProvider';
}

/// See also [ChannelShortsNotifier].
class ChannelShortsNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ChannelShortsNotifier, List<AsyncValue<List<Video>>>> {
  /// See also [ChannelShortsNotifier].
  ChannelShortsNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => ChannelShortsNotifier()..screenIndex = screenIndex,
          from: channelShortsNotifierProvider,
          name: r'channelShortsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelShortsNotifierHash,
          dependencies: ChannelShortsNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChannelShortsNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  ChannelShortsNotifierProvider._internal(
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
  List<AsyncValue<List<Video>>> runNotifierBuild(
    covariant ChannelShortsNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(ChannelShortsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelShortsNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChannelShortsNotifier,
      List<AsyncValue<List<Video>>>> createElement() {
    return _ChannelShortsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelShortsNotifierProvider &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelShortsNotifierRef
    on AutoDisposeNotifierProviderRef<List<AsyncValue<List<Video>>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ChannelShortsNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ChannelShortsNotifier,
        List<AsyncValue<List<Video>>>> with ChannelShortsNotifierRef {
  _ChannelShortsNotifierProviderElement(super.provider);

  @override
  int get screenIndex => (origin as ChannelShortsNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
