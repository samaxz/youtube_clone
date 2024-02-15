// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_playlist_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchPlaylistNotifierHash() =>
    r'5870bfbd31d6b61ea48b72fefc19ed426102cc68';

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

abstract class _$SearchPlaylistNotifier
    extends BuildlessAutoDisposeNotifier<List<BaseInfoState<Video>>> {
  late final int screenIndex;

  List<BaseInfoState<Video>> build(
    int screenIndex,
  );
}

/// See also [SearchPlaylistNotifier].
@ProviderFor(SearchPlaylistNotifier)
const searchPlaylistNotifierProvider = SearchPlaylistNotifierFamily();

/// See also [SearchPlaylistNotifier].
class SearchPlaylistNotifierFamily extends Family<List<BaseInfoState<Video>>> {
  /// See also [SearchPlaylistNotifier].
  const SearchPlaylistNotifierFamily();

  /// See also [SearchPlaylistNotifier].
  SearchPlaylistNotifierProvider call(
    int screenIndex,
  ) {
    return SearchPlaylistNotifierProvider(
      screenIndex,
    );
  }

  @override
  SearchPlaylistNotifierProvider getProviderOverride(
    covariant SearchPlaylistNotifierProvider provider,
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
  String? get name => r'searchPlaylistNotifierProvider';
}

/// See also [SearchPlaylistNotifier].
class SearchPlaylistNotifierProvider extends AutoDisposeNotifierProviderImpl<
    SearchPlaylistNotifier, List<BaseInfoState<Video>>> {
  /// See also [SearchPlaylistNotifier].
  SearchPlaylistNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => SearchPlaylistNotifier()..screenIndex = screenIndex,
          from: searchPlaylistNotifierProvider,
          name: r'searchPlaylistNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchPlaylistNotifierHash,
          dependencies: SearchPlaylistNotifierFamily._dependencies,
          allTransitiveDependencies:
              SearchPlaylistNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  SearchPlaylistNotifierProvider._internal(
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
  List<BaseInfoState<Video>> runNotifierBuild(
    covariant SearchPlaylistNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(SearchPlaylistNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchPlaylistNotifierProvider._internal(
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
  AutoDisposeNotifierProviderElement<SearchPlaylistNotifier,
      List<BaseInfoState<Video>>> createElement() {
    return _SearchPlaylistNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchPlaylistNotifierProvider &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchPlaylistNotifierRef
    on AutoDisposeNotifierProviderRef<List<BaseInfoState<Video>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _SearchPlaylistNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<SearchPlaylistNotifier,
        List<BaseInfoState<Video>>> with SearchPlaylistNotifierRef {
  _SearchPlaylistNotifierProviderElement(super.provider);

  @override
  int get screenIndex => (origin as SearchPlaylistNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
