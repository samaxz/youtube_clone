// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_items_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchItemsNotifierHash() =>
    r'16bd5a3663bcfa3b360b44bc5cac19b90985addd';

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

abstract class _$SearchItemsNotifier
    extends BuildlessNotifier<List<BaseInfoState<Item>>> {
  late final int screenIndex;

  List<BaseInfoState<Item>> build(
    int screenIndex,
  );
}

/// See also [SearchItemsNotifier].
@ProviderFor(SearchItemsNotifier)
const searchItemsNotifierProvider = SearchItemsNotifierFamily();

/// See also [SearchItemsNotifier].
class SearchItemsNotifierFamily extends Family<List<BaseInfoState<Item>>> {
  /// See also [SearchItemsNotifier].
  const SearchItemsNotifierFamily();

  /// See also [SearchItemsNotifier].
  SearchItemsNotifierProvider call(
    int screenIndex,
  ) {
    return SearchItemsNotifierProvider(
      screenIndex,
    );
  }

  @override
  SearchItemsNotifierProvider getProviderOverride(
    covariant SearchItemsNotifierProvider provider,
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
  String? get name => r'searchItemsNotifierProvider';
}

/// See also [SearchItemsNotifier].
class SearchItemsNotifierProvider extends NotifierProviderImpl<
    SearchItemsNotifier, List<BaseInfoState<Item>>> {
  /// See also [SearchItemsNotifier].
  SearchItemsNotifierProvider(
    int screenIndex,
  ) : this._internal(
          () => SearchItemsNotifier()..screenIndex = screenIndex,
          from: searchItemsNotifierProvider,
          name: r'searchItemsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchItemsNotifierHash,
          dependencies: SearchItemsNotifierFamily._dependencies,
          allTransitiveDependencies:
              SearchItemsNotifierFamily._allTransitiveDependencies,
          screenIndex: screenIndex,
        );

  SearchItemsNotifierProvider._internal(
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
  List<BaseInfoState<Item>> runNotifierBuild(
    covariant SearchItemsNotifier notifier,
  ) {
    return notifier.build(
      screenIndex,
    );
  }

  @override
  Override overrideWith(SearchItemsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchItemsNotifierProvider._internal(
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
  NotifierProviderElement<SearchItemsNotifier, List<BaseInfoState<Item>>>
      createElement() {
    return _SearchItemsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchItemsNotifierProvider &&
        other.screenIndex == screenIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screenIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchItemsNotifierRef on NotifierProviderRef<List<BaseInfoState<Item>>> {
  /// The parameter `screenIndex` of this provider.
  int get screenIndex;
}

class _SearchItemsNotifierProviderElement extends NotifierProviderElement<
    SearchItemsNotifier,
    List<BaseInfoState<Item>>> with SearchItemsNotifierRef {
  _SearchItemsNotifierProviderElement(super.provider);

  @override
  int get screenIndex => (origin as SearchItemsNotifierProvider).screenIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
