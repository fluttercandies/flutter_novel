// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookViewModelHash() => r'2711860a77e8abf6bca7428214caaeecaae3b6a8';

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

abstract class _$BookViewModel
    extends BuildlessAutoDisposeAsyncNotifier<BookState> {
  late final String nameBook;

  FutureOr<BookState> build({
    required String nameBook,
  });
}

/// See also [BookViewModel].
@ProviderFor(BookViewModel)
const bookViewModelProvider = BookViewModelFamily();

/// See also [BookViewModel].
class BookViewModelFamily extends Family<AsyncValue<BookState>> {
  /// See also [BookViewModel].
  const BookViewModelFamily();

  /// See also [BookViewModel].
  BookViewModelProvider call({
    required String nameBook,
  }) {
    return BookViewModelProvider(
      nameBook: nameBook,
    );
  }

  @override
  BookViewModelProvider getProviderOverride(
    covariant BookViewModelProvider provider,
  ) {
    return call(
      nameBook: provider.nameBook,
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
  String? get name => r'bookViewModelProvider';
}

/// See also [BookViewModel].
class BookViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BookViewModel, BookState> {
  /// See also [BookViewModel].
  BookViewModelProvider({
    required String nameBook,
  }) : this._internal(
          () => BookViewModel()..nameBook = nameBook,
          from: bookViewModelProvider,
          name: r'bookViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookViewModelHash,
          dependencies: BookViewModelFamily._dependencies,
          allTransitiveDependencies:
              BookViewModelFamily._allTransitiveDependencies,
          nameBook: nameBook,
        );

  BookViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.nameBook,
  }) : super.internal();

  final String nameBook;

  @override
  FutureOr<BookState> runNotifierBuild(
    covariant BookViewModel notifier,
  ) {
    return notifier.build(
      nameBook: nameBook,
    );
  }

  @override
  Override overrideWith(BookViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: BookViewModelProvider._internal(
        () => create()..nameBook = nameBook,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        nameBook: nameBook,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BookViewModel, BookState>
      createElement() {
    return _BookViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookViewModelProvider && other.nameBook == nameBook;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nameBook.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BookViewModelRef on AutoDisposeAsyncNotifierProviderRef<BookState> {
  /// The parameter `nameBook` of this provider.
  String get nameBook;
}

class _BookViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BookViewModel, BookState>
    with BookViewModelRef {
  _BookViewModelProviderElement(super.provider);

  @override
  String get nameBook => (origin as BookViewModelProvider).nameBook;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
