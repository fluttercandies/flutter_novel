// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newSearchViewModelHash() =>
    r'7d41d111081211bee7747fe9989f7b70f678f9b4';

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

abstract class _$NewSearchViewModel
    extends BuildlessAutoDisposeAsyncNotifier<SearchState> {
  late final String searchKey;
  late final BookSourceEntry bookSourceEntry;

  FutureOr<SearchState> build({
    required String searchKey,
    required BookSourceEntry bookSourceEntry,
  });
}

/// 搜索页
/// 时间 2024-9-29
/// 7-bit
///
/// Copied from [NewSearchViewModel].
@ProviderFor(NewSearchViewModel)
const newSearchViewModelProvider = NewSearchViewModelFamily();

/// 搜索页
/// 时间 2024-9-29
/// 7-bit
///
/// Copied from [NewSearchViewModel].
class NewSearchViewModelFamily extends Family<AsyncValue<SearchState>> {
  /// 搜索页
  /// 时间 2024-9-29
  /// 7-bit
  ///
  /// Copied from [NewSearchViewModel].
  const NewSearchViewModelFamily();

  /// 搜索页
  /// 时间 2024-9-29
  /// 7-bit
  ///
  /// Copied from [NewSearchViewModel].
  NewSearchViewModelProvider call({
    required String searchKey,
    required BookSourceEntry bookSourceEntry,
  }) {
    return NewSearchViewModelProvider(
      searchKey: searchKey,
      bookSourceEntry: bookSourceEntry,
    );
  }

  @override
  NewSearchViewModelProvider getProviderOverride(
    covariant NewSearchViewModelProvider provider,
  ) {
    return call(
      searchKey: provider.searchKey,
      bookSourceEntry: provider.bookSourceEntry,
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
  String? get name => r'newSearchViewModelProvider';
}

/// 搜索页
/// 时间 2024-9-29
/// 7-bit
///
/// Copied from [NewSearchViewModel].
class NewSearchViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    NewSearchViewModel, SearchState> {
  /// 搜索页
  /// 时间 2024-9-29
  /// 7-bit
  ///
  /// Copied from [NewSearchViewModel].
  NewSearchViewModelProvider({
    required String searchKey,
    required BookSourceEntry bookSourceEntry,
  }) : this._internal(
          () => NewSearchViewModel()
            ..searchKey = searchKey
            ..bookSourceEntry = bookSourceEntry,
          from: newSearchViewModelProvider,
          name: r'newSearchViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$newSearchViewModelHash,
          dependencies: NewSearchViewModelFamily._dependencies,
          allTransitiveDependencies:
              NewSearchViewModelFamily._allTransitiveDependencies,
          searchKey: searchKey,
          bookSourceEntry: bookSourceEntry,
        );

  NewSearchViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchKey,
    required this.bookSourceEntry,
  }) : super.internal();

  final String searchKey;
  final BookSourceEntry bookSourceEntry;

  @override
  FutureOr<SearchState> runNotifierBuild(
    covariant NewSearchViewModel notifier,
  ) {
    return notifier.build(
      searchKey: searchKey,
      bookSourceEntry: bookSourceEntry,
    );
  }

  @override
  Override overrideWith(NewSearchViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: NewSearchViewModelProvider._internal(
        () => create()
          ..searchKey = searchKey
          ..bookSourceEntry = bookSourceEntry,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchKey: searchKey,
        bookSourceEntry: bookSourceEntry,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<NewSearchViewModel, SearchState>
      createElement() {
    return _NewSearchViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NewSearchViewModelProvider &&
        other.searchKey == searchKey &&
        other.bookSourceEntry == bookSourceEntry;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchKey.hashCode);
    hash = _SystemHash.combine(hash, bookSourceEntry.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NewSearchViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<SearchState> {
  /// The parameter `searchKey` of this provider.
  String get searchKey;

  /// The parameter `bookSourceEntry` of this provider.
  BookSourceEntry get bookSourceEntry;
}

class _NewSearchViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NewSearchViewModel,
        SearchState> with NewSearchViewModelRef {
  _NewSearchViewModelProviderElement(super.provider);

  @override
  String get searchKey => (origin as NewSearchViewModelProvider).searchKey;
  @override
  BookSourceEntry get bookSourceEntry =>
      (origin as NewSearchViewModelProvider).bookSourceEntry;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
