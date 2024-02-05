// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_subscription_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelSubscriptionNotifierHash() =>
    r'461215b3f2e4422da043fe0aab616229aa22cdfd';

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

abstract class _$ChannelSubscriptionNotifier
    extends BuildlessAutoDisposeNotifier<List<AsyncValue<bool>>> {
  late final int screenIndex;
  late final String channelId;

  List<AsyncValue<bool>> build({
    required int screenIndex,
    required String channelId,
  });
}

/// See also [ChannelSubscriptionNotifier].
@ProviderFor(ChannelSubscriptionNotifier)
const channelSubscriptionNotifierProvider = ChannelSubscriptionNotifierFamily();

/// See also [ChannelSubscriptionNotifier].
class ChannelSubscriptionNotifierFamily extends Family<List<AsyncValue<bool>>> {
  /// See also [ChannelSubscriptionNotifier].
  const ChannelSubscriptionNotifierFamily();

  /// See also [ChannelSubscriptionNotifier].
  ChannelSubscriptionNotifierProvider call({
    required int screenIndex,
    required String channelId,
  }) {
    return ChannelSubscriptionNotifierProvider(
      screenIndex: screenIndex,
      channelId: channelId,
    );
  }

  @override
  ChannelSubscriptionNotifierProvider getProviderOverride(
    covariant ChannelSubscriptionNotifierProvider provider,
  ) {
    return call(
      screenIndex: provider.screenIndex,
      channelId: provider.channelId,
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
  String? get name => r'channelSubscriptionNotifierProvider';
}

/// See also [ChannelSubscriptionNotifier].
class ChannelSubscriptionNotifierProvider
    extends AutoDisposeNotifierProviderImpl<ChannelSubscriptionNotifier,
        List<AsyncValue<bool>>> {
  /// See also [ChannelSubscriptionNotifier].
  ChannelSubscriptionNotifierProvider({
    required int screenIndex,
    required String channelId,
  }) : this._internal(
          () => ChannelSubscriptionNotifier()
            ..screenIndex = screenIndex
            ..channelId = channelId,
          from: channelSubscriptionNotifierProvider,
          name: r'channelSubscriptionNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelSubscriptionNotifierHash,
          dependencies: ChannelSubscriptionNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChannelSubscriptionNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
          channelId: channelId,
        );

  ChannelSubscriptionNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.screenIndex,
    required this.channelId,
  }) : super.internal();

  final int screenIndex;
  final String channelId;

  @override
  List<AsyncValue<bool>> runNotifierBuild(
    covariant ChannelSubscriptionNotifier notifier,
  ) {
    return notifier.build(
      screenIndex: screenIndex,
      channelId: channelId,
    );
  }

  @override
  Override overrideWith(ChannelSubscriptionNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelSubscriptionNotifierProvider._internal(
        () => create()
          ..screenIndex = screenIndex
          ..channelId = channelId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        screenIndex: screenIndex,
        channelId: channelId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ChannelSubscriptionNotifier,
      List<AsyncValue<bool>>> createElement() {
    return _ChannelSubscriptionNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelSubscriptionNotifierProvider &&
        other.screenIndex == screenIndex &&
        other.channelId == channelId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);
    hash = _SystemHash.combine(hash, channelId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelSubscriptionNotifierRef
    on AutoDisposeNotifierProviderRef<List<AsyncValue<bool>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;

  /// The parameter `channelId` of this provider.
  String get channelId;
}

class _ChannelSubscriptionNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ChannelSubscriptionNotifier,
        List<AsyncValue<bool>>> with ChannelSubscriptionNotifierRef {
  _ChannelSubscriptionNotifierProviderElement(super.provider);

  @override
  int get screenIndex =>
      (origin as ChannelSubscriptionNotifierProvider).screenIndex;
  @override
  String get channelId =>
      (origin as ChannelSubscriptionNotifierProvider).channelId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
