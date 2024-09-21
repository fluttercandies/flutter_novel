// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryViewModelHash() => r'b20abd89c97b47daba267c0874185b5abc41ebfc';

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

abstract class _$CategoryViewModel
    extends BuildlessAutoDisposeAsyncNotifier<CategoryState> {
  late final CategoryEnum categoryEnum;

  FutureOr<CategoryState> build({
    required CategoryEnum categoryEnum,
  });
}

/// See also [CategoryViewModel].
@ProviderFor(CategoryViewModel)
const categoryViewModelProvider = CategoryViewModelFamily();

/// See also [CategoryViewModel].
class CategoryViewModelFamily extends Family<AsyncValue<CategoryState>> {
  /// See also [CategoryViewModel].
  const CategoryViewModelFamily();

  /// See also [CategoryViewModel].
  CategoryViewModelProvider call({
    required CategoryEnum categoryEnum,
  }) {
    return CategoryViewModelProvider(
      categoryEnum: categoryEnum,
    );
  }

  @override
  CategoryViewModelProvider getProviderOverride(
    covariant CategoryViewModelProvider provider,
  ) {
    return call(
      categoryEnum: provider.categoryEnum,
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
  String? get name => r'categoryViewModelProvider';
}

/// See also [CategoryViewModel].
class CategoryViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CategoryViewModel, CategoryState> {
  /// See also [CategoryViewModel].
  CategoryViewModelProvider({
    required CategoryEnum categoryEnum,
  }) : this._internal(
          () => CategoryViewModel()..categoryEnum = categoryEnum,
          from: categoryViewModelProvider,
          name: r'categoryViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryViewModelHash,
          dependencies: CategoryViewModelFamily._dependencies,
          allTransitiveDependencies:
              CategoryViewModelFamily._allTransitiveDependencies,
          categoryEnum: categoryEnum,
        );

  CategoryViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryEnum,
  }) : super.internal();

  final CategoryEnum categoryEnum;

  @override
  FutureOr<CategoryState> runNotifierBuild(
    covariant CategoryViewModel notifier,
  ) {
    return notifier.build(
      categoryEnum: categoryEnum,
    );
  }

  @override
  Override overrideWith(CategoryViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: CategoryViewModelProvider._internal(
        () => create()..categoryEnum = categoryEnum,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryEnum: categoryEnum,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CategoryViewModel, CategoryState>
      createElement() {
    return _CategoryViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryViewModelProvider &&
        other.categoryEnum == categoryEnum;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryEnum.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CategoryViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<CategoryState> {
  /// The parameter `categoryEnum` of this provider.
  CategoryEnum get categoryEnum;
}

class _CategoryViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CategoryViewModel,
        CategoryState> with CategoryViewModelRef {
  _CategoryViewModelProviderElement(super.provider);

  @override
  CategoryEnum get categoryEnum =>
      (origin as CategoryViewModelProvider).categoryEnum;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
