// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchViewModelHash() => r'67f5eb9b9e2b7977016627e3dc3b69992163e312';

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

abstract class _$SearchViewModel
    extends BuildlessAutoDisposeAsyncNotifier<SearchState> {
  late final String bookName;

  FutureOr<SearchState> build({
    required String bookName,
  });
}

/// See also [SearchViewModel].
@ProviderFor(SearchViewModel)
const searchViewModelProvider = SearchViewModelFamily();

/// See also [SearchViewModel].
class SearchViewModelFamily extends Family<AsyncValue<SearchState>> {
  /// See also [SearchViewModel].
  const SearchViewModelFamily();

  /// See also [SearchViewModel].
  SearchViewModelProvider call({
    required String bookName,
  }) {
    return SearchViewModelProvider(
      bookName: bookName,
    );
  }

  @override
  SearchViewModelProvider getProviderOverride(
    covariant SearchViewModelProvider provider,
  ) {
    return call(
      bookName: provider.bookName,
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
  String? get name => r'searchViewModelProvider';
}

/// See also [SearchViewModel].
class SearchViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SearchViewModel, SearchState> {
  /// See also [SearchViewModel].
  SearchViewModelProvider({
    required String bookName,
  }) : this._internal(
          () => SearchViewModel()..bookName = bookName,
          from: searchViewModelProvider,
          name: r'searchViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchViewModelHash,
          dependencies: SearchViewModelFamily._dependencies,
          allTransitiveDependencies:
              SearchViewModelFamily._allTransitiveDependencies,
          bookName: bookName,
        );

  SearchViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookName,
  }) : super.internal();

  final String bookName;

  @override
  FutureOr<SearchState> runNotifierBuild(
    covariant SearchViewModel notifier,
  ) {
    return notifier.build(
      bookName: bookName,
    );
  }

  @override
  Override overrideWith(SearchViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchViewModelProvider._internal(
        () => create()..bookName = bookName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookName: bookName,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SearchViewModel, SearchState>
      createElement() {
    return _SearchViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchViewModelProvider && other.bookName == bookName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchViewModelRef on AutoDisposeAsyncNotifierProviderRef<SearchState> {
  /// The parameter `bookName` of this provider.
  String get bookName;
}

class _SearchViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SearchViewModel,
        SearchState> with SearchViewModelRef {
  _SearchViewModelProviderElement(super.provider);

  @override
  String get bookName => (origin as SearchViewModelProvider).bookName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
