// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subscriptionsHash() => r'137af2663d8726ecbcc4bcb6091e77360f3d24e3';

/// See also [subscriptions].
@ProviderFor(subscriptions)
final subscriptionsProvider = AutoDisposeFutureProvider<SubState>.internal(
  subscriptions,
  name: r'subscriptionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$subscriptionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SubscriptionsRef = AutoDisposeFutureProviderRef<SubState>;
String _$subscriptionNotifierHash() =>
    r'aebb9c5c52c05dd855ed48caedda52084ed4ce1d';

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

abstract class _$SubscriptionNotifier
    extends BuildlessAutoDisposeNotifier<List<AsyncValue<bool>>> {
  late final String channelId;

  List<AsyncValue<bool>> build(
    String channelId,
  );
}

/// See also [SubscriptionNotifier].
@ProviderFor(SubscriptionNotifier)
const subscriptionNotifierProvider = SubscriptionNotifierFamily();

/// See also [SubscriptionNotifier].
class SubscriptionNotifierFamily extends Family<List<AsyncValue<bool>>> {
  /// See also [SubscriptionNotifier].
  const SubscriptionNotifierFamily();

  /// See also [SubscriptionNotifier].
  SubscriptionNotifierProvider call(
    String channelId,
  ) {
    return SubscriptionNotifierProvider(
      channelId,
    );
  }

  @override
  SubscriptionNotifierProvider getProviderOverride(
    covariant SubscriptionNotifierProvider provider,
  ) {
    return call(
      provider.channelId,
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
  String? get name => r'subscriptionNotifierProvider';
}

/// See also [SubscriptionNotifier].
class SubscriptionNotifierProvider extends AutoDisposeNotifierProviderImpl<
    SubscriptionNotifier, List<AsyncValue<bool>>> {
  /// See also [SubscriptionNotifier].
  SubscriptionNotifierProvider(
    String channelId,
  ) : this._internal(
          () => SubscriptionNotifier()..channelId = channelId,
          from: subscriptionNotifierProvider,
          name: r'subscriptionNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$subscriptionNotifierHash,
          dependencies: SubscriptionNotifierFamily._dependencies,
          allTransitiveDependencies:
              SubscriptionNotifierFamily._allTransitiveDependencies,
          channelId: channelId,
        );

  SubscriptionNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channelId,
  }) : super.internal();

  final String channelId;

  @override
  List<AsyncValue<bool>> runNotifierBuild(
    covariant SubscriptionNotifier notifier,
  ) {
    return notifier.build(
      channelId,
    );
  }

  @override
  Override overrideWith(SubscriptionNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SubscriptionNotifierProvider._internal(
        () => create()..channelId = channelId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channelId: channelId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SubscriptionNotifier,
      List<AsyncValue<bool>>> createElement() {
    return _SubscriptionNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubscriptionNotifierProvider &&
        other.channelId == channelId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubscriptionNotifierRef
    on AutoDisposeNotifierProviderRef<List<AsyncValue<bool>>> {
  /// The parameter `channelId` of this provider.
  String get channelId;
}

class _SubscriptionNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<SubscriptionNotifier,
        List<AsyncValue<bool>>> with SubscriptionNotifierRef {
  _SubscriptionNotifierProviderElement(super.provider);

  @override
  String get channelId => (origin as SubscriptionNotifierProvider).channelId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
