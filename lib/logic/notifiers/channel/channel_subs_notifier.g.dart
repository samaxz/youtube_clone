// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_subs_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelSubsNotifierHash() =>
    r'53d30038431e05ac03154dcf862819b7fd6b17fb';

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

abstract class _$ChannelSubsNotifier extends BuildlessAutoDisposeNotifier<
    List<AsyncValue<List<ChannelSubscription>>>> {
  late final int screenIndex;

  List<AsyncValue<List<ChannelSubscription>>> build(
    int screenIndex,
  );
}

/// See also [ChannelSubsNotifier].
@ProviderFor(ChannelSubsNotifier)
const channelSubsNotifierProvider = ChannelSubsNotifierFamily();

/// See also [ChannelSubsNotifier].
class ChannelSubsNotifierFamily
    extends Family<List<AsyncValue<List<ChannelSubscription>>>> {
  /// See also [ChannelSubsNotifier].
  const ChannelSubsNotifierFamily();

  /// See also [ChannelSubsNotifier].
  ChannelSubsNotifierProvider call(
    int screenIndex,
  ) {
    return ChannelSubsNotifierProvider(
      screenIndex,
    );
  }

  @override
  ChannelSubsNotifierProvider getProviderOverride(
    covariant ChannelSubsNotifierProvider provider,
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
  String? get name => r'channelSubsNotifierProvider';
}

/// See also [ChannelSubsNotifier].
class ChannelSubsNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ChannelSubsNotifier, List<AsyncValue<List<ChannelSubscription>>>> {
  /// See also [ChannelSubsNotifier].
  ChannelSubsNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => ChannelSubsNotifier()..screenIndex = screenIndex,
          from: channelSubsNotifierProvider,
          name: r'channelSubsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelSubsNotifierHash,
          dependencies: ChannelSubsNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChannelSubsNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  ChannelSubsNotifierProvider._internal(
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
  List<AsyncValue<List<ChannelSubscription>>> runNotifierBuild(
    covariant ChannelSubsNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(ChannelSubsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelSubsNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChannelSubsNotifier,
      List<AsyncValue<List<ChannelSubscription>>>> createElement() {
    return _ChannelSubsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelSubsNotifierProvider &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelSubsNotifierRef on AutoDisposeNotifierProviderRef<
    List<AsyncValue<List<ChannelSubscription>>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ChannelSubsNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ChannelSubsNotifier,
        List<AsyncValue<List<ChannelSubscription>>>>
    with ChannelSubsNotifierRef {
  _ChannelSubsNotifierProviderElement(super.provider);

  @override
  int get screenIndex => (origin as ChannelSubsNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
