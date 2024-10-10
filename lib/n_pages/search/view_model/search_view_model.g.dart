// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newSearchViewModelHash() =>
    r'80dd3259e93d5cf2da51b3ae4ee0a1b3dc7f4059';

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

  FutureOr<SearchState> build({
    required String searchKey,
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
  }) {
    return NewSearchViewModelProvider(
      searchKey: searchKey,
    );
  }

  @override
  NewSearchViewModelProvider getProviderOverride(
    covariant NewSearchViewModelProvider provider,
  ) {
    return call(
      searchKey: provider.searchKey,
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
  }) : this._internal(
          () => NewSearchViewModel()..searchKey = searchKey,
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
        );

  NewSearchViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchKey,
  }) : super.internal();

  final String searchKey;

  @override
  FutureOr<SearchState> runNotifierBuild(
    covariant NewSearchViewModel notifier,
  ) {
    return notifier.build(
      searchKey: searchKey,
    );
  }

  @override
  Override overrideWith(NewSearchViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: NewSearchViewModelProvider._internal(
        () => create()..searchKey = searchKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchKey: searchKey,
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
    return other is NewSearchViewModelProvider && other.searchKey == searchKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NewSearchViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<SearchState> {
  /// The parameter `searchKey` of this provider.
  String get searchKey;
}

class _NewSearchViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NewSearchViewModel,
        SearchState> with NewSearchViewModelRef {
  _NewSearchViewModelProviderElement(super.provider);

  @override
  String get searchKey => (origin as NewSearchViewModelProvider).searchKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
