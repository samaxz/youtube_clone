// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_home_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelHomeNotifierHash() =>
    r'85198b137f8ac528409894113b1b8a2ebb2fef9a';

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

abstract class _$ChannelHomeNotifier
    extends BuildlessAutoDisposeNotifier<List<AsyncValue<Uploads>>> {
  late final int screenIndex;

  List<AsyncValue<Uploads>> build(
    int screenIndex,
  );
}

/// See also [ChannelHomeNotifier].
@ProviderFor(ChannelHomeNotifier)
const channelHomeNotifierProvider = ChannelHomeNotifierFamily();

/// See also [ChannelHomeNotifier].
class ChannelHomeNotifierFamily extends Family<List<AsyncValue<Uploads>>> {
  /// See also [ChannelHomeNotifier].
  const ChannelHomeNotifierFamily();

  /// See also [ChannelHomeNotifier].
  ChannelHomeNotifierProvider call(
    int screenIndex,
  ) {
    return ChannelHomeNotifierProvider(
      screenIndex,
    );
  }

  @override
  ChannelHomeNotifierProvider getProviderOverride(
    covariant ChannelHomeNotifierProvider provider,
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
  String? get name => r'channelHomeNotifierProvider';
}

/// See also [ChannelHomeNotifier].
class ChannelHomeNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ChannelHomeNotifier, List<AsyncValue<Uploads>>> {
  /// See also [ChannelHomeNotifier].
  ChannelHomeNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => ChannelHomeNotifier()..screenIndex = screenIndex,
          from: channelHomeNotifierProvider,
          name: r'channelHomeNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelHomeNotifierHash,
          dependencies: ChannelHomeNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChannelHomeNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  ChannelHomeNotifierProvider._internal(
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
  List<AsyncValue<Uploads>> runNotifierBuild(
    covariant ChannelHomeNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(ChannelHomeNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelHomeNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChannelHomeNotifier,
      List<AsyncValue<Uploads>>> createElement() {
    return _ChannelHomeNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelHomeNotifierProvider &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelHomeNotifierRef
    on AutoDisposeNotifierProviderRef<List<AsyncValue<Uploads>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ChannelHomeNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ChannelHomeNotifier,
        List<AsyncValue<Uploads>>> with ChannelHomeNotifierRef {
  _ChannelHomeNotifierProviderElement(super.provider);

  @override
  int get screenIndex => (origin as ChannelHomeNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
