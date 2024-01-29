// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_community_posts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelCommunityNotifierHash() =>
    r'2a1b196e4fa4ef66838c7fb268c7a92aa00d91e6';

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

abstract class _$ChannelCommunityNotifier extends BuildlessAutoDisposeNotifier<
    List<AsyncValue<List<CommunityPost>>>> {
  late final int screenIndex;

  List<AsyncValue<List<CommunityPost>>> build(
    int screenIndex,
  );
}

/// See also [ChannelCommunityNotifier].
@ProviderFor(ChannelCommunityNotifier)
const channelCommunityNotifierProvider = ChannelCommunityNotifierFamily();

/// See also [ChannelCommunityNotifier].
class ChannelCommunityNotifierFamily
    extends Family<List<AsyncValue<List<CommunityPost>>>> {
  /// See also [ChannelCommunityNotifier].
  const ChannelCommunityNotifierFamily();

  /// See also [ChannelCommunityNotifier].
  ChannelCommunityNotifierProvider call(
    int screenIndex,
  ) {
    return ChannelCommunityNotifierProvider(
      screenIndex,
    );
  }

  @override
  ChannelCommunityNotifierProvider getProviderOverride(
    covariant ChannelCommunityNotifierProvider provider,
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
  String? get name => r'channelCommunityNotifierProvider';
}

/// See also [ChannelCommunityNotifier].
class ChannelCommunityNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ChannelCommunityNotifier, List<AsyncValue<List<CommunityPost>>>> {
  /// See also [ChannelCommunityNotifier].
  ChannelCommunityNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => ChannelCommunityNotifier()..screenIndex = screenIndex,
          from: channelCommunityNotifierProvider,
          name: r'channelCommunityNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelCommunityNotifierHash,
          dependencies: ChannelCommunityNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChannelCommunityNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  ChannelCommunityNotifierProvider._internal(
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
  List<AsyncValue<List<CommunityPost>>> runNotifierBuild(
    covariant ChannelCommunityNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(ChannelCommunityNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelCommunityNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChannelCommunityNotifier,
      List<AsyncValue<List<CommunityPost>>>> createElement() {
    return _ChannelCommunityNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelCommunityNotifierProvider &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelCommunityNotifierRef
    on AutoDisposeNotifierProviderRef<List<AsyncValue<List<CommunityPost>>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ChannelCommunityNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ChannelCommunityNotifier,
        List<AsyncValue<List<CommunityPost>>>>
    with ChannelCommunityNotifierRef {
  _ChannelCommunityNotifierProviderElement(super.provider);

  @override
  int get screenIndex =>
      (origin as ChannelCommunityNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
