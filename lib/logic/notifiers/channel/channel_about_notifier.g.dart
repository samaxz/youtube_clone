// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_about_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$channelAboutNotifierHash() =>
    r'8ea5709f05465d2b0f4582f94f3333527d38b697';

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

abstract class _$ChannelAboutNotifier
    extends BuildlessAutoDisposeNotifier<List<AsyncValue<About>>> {
  late final int screenIndex;

  List<AsyncValue<About>> build(
    int screenIndex,
  );
}

/// See also [ChannelAboutNotifier].
@ProviderFor(ChannelAboutNotifier)
const channelAboutNotifierProvider = ChannelAboutNotifierFamily();

/// See also [ChannelAboutNotifier].
class ChannelAboutNotifierFamily extends Family<List<AsyncValue<About>>> {
  /// See also [ChannelAboutNotifier].
  const ChannelAboutNotifierFamily();

  /// See also [ChannelAboutNotifier].
  ChannelAboutNotifierProvider call(
    int screenIndex,
  ) {
    return ChannelAboutNotifierProvider(
      screenIndex,
    );
  }

  @override
  ChannelAboutNotifierProvider getProviderOverride(
    covariant ChannelAboutNotifierProvider provider,
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
  String? get name => r'channelAboutNotifierProvider';
}

/// See also [ChannelAboutNotifier].
class ChannelAboutNotifierProvider extends AutoDisposeNotifierProviderImpl<
    ChannelAboutNotifier, List<AsyncValue<About>>> {
  /// See also [ChannelAboutNotifier].
  ChannelAboutNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => ChannelAboutNotifier()..screenIndex = screenIndex,
          from: channelAboutNotifierProvider,
          name: r'channelAboutNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$channelAboutNotifierHash,
          dependencies: ChannelAboutNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChannelAboutNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  ChannelAboutNotifierProvider._internal(
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
  List<AsyncValue<About>> runNotifierBuild(
    covariant ChannelAboutNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(ChannelAboutNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChannelAboutNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<ChannelAboutNotifier,
      List<AsyncValue<About>>> createElement() {
    return _ChannelAboutNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChannelAboutNotifierProvider &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChannelAboutNotifierRef
    on AutoDisposeNotifierProviderRef<List<AsyncValue<About>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _ChannelAboutNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<ChannelAboutNotifier,
        List<AsyncValue<About>>> with ChannelAboutNotifierRef {
  _ChannelAboutNotifierProviderElement(super.provider);

  @override
  int get screenIndex => (origin as ChannelAboutNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
