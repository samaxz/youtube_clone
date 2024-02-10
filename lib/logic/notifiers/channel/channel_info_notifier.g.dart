// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_info_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelInfoNotifierHash() =>
    r'ed0c9e76752648de7782862e6484338324ac8722';

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

abstract class _$ChannelInfoNotifier
    extends BuildlessAutoDisposeNotifier<List<AsyncValue<Channel>>> {
  late final int screenIndex;

  List<AsyncValue<Channel>> build(
    int screenIndex,
  );
}

/// See also [ChannelInfoNotifier].
@ProviderFor(ChannelInfoNotifier)
const channelInfoNotifierProvider = ChannelInfoNotifierFamily();

/// See also [ChannelInfoNotifier].
class ChannelInfoNotifierFamily extends Family<List<AsyncValue<Channel>>> {
  /// See also [ChannelInfoNotifier].
  const ChannelInfoNotifierFamily();

  /// See also [ChannelInfoNotifier].
  ChannelInfoNotifierProvider call(
    int screenIndex,
  ) {
    return ChannelInfoNotifierProvider(
      screenIndex,
    );
  }

  @override
  ChannelInfoNotifierProvider getProviderOverride(
    covariant ChannelInfoNotifierProvider provider,
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
  String? get name => r'channelInfoNotifierProvider';
}

/// See also [ChannelInfoNotifier].
class ChannelInfoNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ChannelInfoNotifier, List<AsyncValue<Channel>>> {
  /// See also [ChannelInfoNotifier].
  ChannelInfoNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => ChannelInfoNotifier()..screenIndex = screenIndex,
          from: channelInfoNotifierProvider,
          name: r'channelInfoNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelInfoNotifierHash,
          dependencies: ChannelInfoNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChannelInfoNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  ChannelInfoNotifierProvider._internal(
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
  List<AsyncValue<Channel>> runNotifierBuild(
    covariant ChannelInfoNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(ChannelInfoNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelInfoNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChannelInfoNotifier,
      List<AsyncValue<Channel>>> createElement() {
    return _ChannelInfoNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelInfoNotifierProvider &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelInfoNotifierRef
    on AutoDisposeNotifierProviderRef<List<AsyncValue<Channel>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ChannelInfoNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ChannelInfoNotifier,
        List<AsyncValue<Channel>>> with ChannelInfoNotifierRef {
  _ChannelInfoNotifierProviderElement(super.provider);

  @override
  int get screenIndex => (origin as ChannelInfoNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
