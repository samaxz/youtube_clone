// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_playlists_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelPlaylistsNotifierHash() =>
    r'ebe0268da11996f2ab30bdf85d4c00ee7dcb58d8';

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

abstract class _$ChannelPlaylistsNotifier
    extends BuildlessAutoDisposeNotifier<List<AsyncValue<List<Playlist>>>> {
  late final int screenIndex;

  List<AsyncValue<List<Playlist>>> build(
    int screenIndex,
  );
}

/// See also [ChannelPlaylistsNotifier].
@ProviderFor(ChannelPlaylistsNotifier)
const channelPlaylistsNotifierProvider = ChannelPlaylistsNotifierFamily();

/// See also [ChannelPlaylistsNotifier].
class ChannelPlaylistsNotifierFamily
    extends Family<List<AsyncValue<List<Playlist>>>> {
  /// See also [ChannelPlaylistsNotifier].
  const ChannelPlaylistsNotifierFamily();

  /// See also [ChannelPlaylistsNotifier].
  ChannelPlaylistsNotifierProvider call(
    int screenIndex,
  ) {
    return ChannelPlaylistsNotifierProvider(
      screenIndex,
    );
  }

  @override
  ChannelPlaylistsNotifierProvider getProviderOverride(
    covariant ChannelPlaylistsNotifierProvider provider,
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
  String? get name => r'channelPlaylistsNotifierProvider';
}

/// See also [ChannelPlaylistsNotifier].
class ChannelPlaylistsNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ChannelPlaylistsNotifier, List<AsyncValue<List<Playlist>>>> {
  /// See also [ChannelPlaylistsNotifier].
  ChannelPlaylistsNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => ChannelPlaylistsNotifier()..screenIndex = screenIndex,
          from: channelPlaylistsNotifierProvider,
          name: r'channelPlaylistsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelPlaylistsNotifierHash,
          dependencies: ChannelPlaylistsNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChannelPlaylistsNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  ChannelPlaylistsNotifierProvider._internal(
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
  List<AsyncValue<List<Playlist>>> runNotifierBuild(
    covariant ChannelPlaylistsNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(ChannelPlaylistsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelPlaylistsNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChannelPlaylistsNotifier,
      List<AsyncValue<List<Playlist>>>> createElement() {
    return _ChannelPlaylistsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelPlaylistsNotifierProvider &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelPlaylistsNotifierRef
    on AutoDisposeNotifierProviderRef<List<AsyncValue<List<Playlist>>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ChannelPlaylistsNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ChannelPlaylistsNotifier,
        List<AsyncValue<List<Playlist>>>> with ChannelPlaylistsNotifierRef {
  _ChannelPlaylistsNotifierProviderElement(super.provider);

  @override
  int get screenIndex =>
      (origin as ChannelPlaylistsNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
