// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newSearchViewModelHash() =>
    r'420746b44bb41e2b485437484c278024b8707ebc';

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
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final String searchKey;
  late final BookSourceEntry bookSourceEntry;

  FutureOr<void> build({
    required String searchKey,
    required BookSourceEntry bookSourceEntry,
  });
}

/// See also [NewSearchViewModel].
@ProviderFor(NewSearchViewModel)
const newSearchViewModelProvider = NewSearchViewModelFamily();

/// See also [NewSearchViewModel].
class NewSearchViewModelFamily extends Family<AsyncValue<void>> {
  /// See also [NewSearchViewModel].
  const NewSearchViewModelFamily();

  /// See also [NewSearchViewModel].
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

/// See also [NewSearchViewModel].
class NewSearchViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<NewSearchViewModel, void> {
  /// See also [NewSearchViewModel].
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
  FutureOr<void> runNotifierBuild(
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
  AutoDisposeAsyncNotifierProviderElement<NewSearchViewModel, void>
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

mixin NewSearchViewModelRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `searchKey` of this provider.
  String get searchKey;

  /// The parameter `bookSourceEntry` of this provider.
  BookSourceEntry get bookSourceEntry;
}

class _NewSearchViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NewSearchViewModel, void>
    with NewSearchViewModelRef {
  _NewSearchViewModelProviderElement(super.provider);

  @override
  String get searchKey => (origin as NewSearchViewModelProvider).searchKey;
  @override
  BookSourceEntry get bookSourceEntry =>
      (origin as NewSearchViewModelProvider).bookSourceEntry;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
