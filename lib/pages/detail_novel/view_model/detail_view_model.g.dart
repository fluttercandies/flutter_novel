// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$detailViewModelHash() => r'93355126108a8ba0d607694184181479c36583e7';

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

abstract class _$DetailViewModel
    extends BuildlessAutoDisposeAsyncNotifier<DetailState> {
  late final String urlBook;

  FutureOr<DetailState> build({
    required String urlBook,
  });
}

/// See also [DetailViewModel].
@ProviderFor(DetailViewModel)
const detailViewModelProvider = DetailViewModelFamily();

/// See also [DetailViewModel].
class DetailViewModelFamily extends Family<AsyncValue<DetailState>> {
  /// See also [DetailViewModel].
  const DetailViewModelFamily();

  /// See also [DetailViewModel].
  DetailViewModelProvider call({
    required String urlBook,
  }) {
    return DetailViewModelProvider(
      urlBook: urlBook,
    );
  }

  @override
  DetailViewModelProvider getProviderOverride(
    covariant DetailViewModelProvider provider,
  ) {
    return call(
      urlBook: provider.urlBook,
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
  String? get name => r'detailViewModelProvider';
}

/// See also [DetailViewModel].
class DetailViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DetailViewModel, DetailState> {
  /// See also [DetailViewModel].
  DetailViewModelProvider({
    required String urlBook,
  }) : this._internal(
          () => DetailViewModel()..urlBook = urlBook,
          from: detailViewModelProvider,
          name: r'detailViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$detailViewModelHash,
          dependencies: DetailViewModelFamily._dependencies,
          allTransitiveDependencies:
              DetailViewModelFamily._allTransitiveDependencies,
          urlBook: urlBook,
        );

  DetailViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.urlBook,
  }) : super.internal();

  final String urlBook;

  @override
  FutureOr<DetailState> runNotifierBuild(
    covariant DetailViewModel notifier,
  ) {
    return notifier.build(
      urlBook: urlBook,
    );
  }

  @override
  Override overrideWith(DetailViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailViewModelProvider._internal(
        () => create()..urlBook = urlBook,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        urlBook: urlBook,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DetailViewModel, DetailState>
      createElement() {
    return _DetailViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailViewModelProvider && other.urlBook == urlBook;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, urlBook.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DetailViewModelRef on AutoDisposeAsyncNotifierProviderRef<DetailState> {
  /// The parameter `urlBook` of this provider.
  String get urlBook;
}

class _DetailViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DetailViewModel,
        DetailState> with DetailViewModelRef {
  _DetailViewModelProviderElement(super.provider);

  @override
  String get urlBook => (origin as DetailViewModelProvider).urlBook;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
