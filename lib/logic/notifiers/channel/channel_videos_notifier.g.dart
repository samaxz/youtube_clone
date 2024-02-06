// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_videos_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelVideosNotifierHash() =>
    r'0e95a37a3d4126ff2aec8b67813d30b6f4824dc1';

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

abstract class _$ChannelVideosNotifier
    extends BuildlessAutoDisposeNotifier<List<AsyncValue<List<Video>>>> {
  late final int screenIndex;

  List<AsyncValue<List<Video>>> build(
    int screenIndex,
  );
}

/// See also [ChannelVideosNotifier].
@ProviderFor(ChannelVideosNotifier)
const channelVideosNotifierProvider = ChannelVideosNotifierFamily();

/// See also [ChannelVideosNotifier].
class ChannelVideosNotifierFamily
    extends Family<List<AsyncValue<List<Video>>>> {
  /// See also [ChannelVideosNotifier].
  const ChannelVideosNotifierFamily();

  /// See also [ChannelVideosNotifier].
  ChannelVideosNotifierProvider call(
    int screenIndex,
  ) {
    return ChannelVideosNotifierProvider(
      screenIndex,
    );
  }

  @override
  ChannelVideosNotifierProvider getProviderOverride(
    covariant ChannelVideosNotifierProvider provider,
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
  String? get name => r'channelVideosNotifierProvider';
}

/// See also [ChannelVideosNotifier].
class ChannelVideosNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ChannelVideosNotifier, List<AsyncValue<List<Video>>>> {
  /// See also [ChannelVideosNotifier].
  ChannelVideosNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => ChannelVideosNotifier()..screenIndex = screenIndex,
          from: channelVideosNotifierProvider,
          name: r'channelVideosNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelVideosNotifierHash,
          dependencies: ChannelVideosNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChannelVideosNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  ChannelVideosNotifierProvider._internal(
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
    covariant ChannelVideosNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(ChannelVideosNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelVideosNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChannelVideosNotifier,
      List<AsyncValue<List<Video>>>> createElement() {
    return _ChannelVideosNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelVideosNotifierProvider &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelVideosNotifierRef
    on AutoDisposeNotifierProviderRef<List<AsyncValue<List<Video>>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ChannelVideosNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ChannelVideosNotifier,
        List<AsyncValue<List<Video>>>> with ChannelVideosNotifierRef {
  _ChannelVideosNotifierProviderElement(super.provider);

  @override
  int get screenIndex => (origin as ChannelVideosNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
