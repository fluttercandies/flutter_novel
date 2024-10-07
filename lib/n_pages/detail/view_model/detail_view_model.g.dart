// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newDetailViewModelHash() =>
    r'a706f2578f93795ed55ba9435310584ca80d1e0a';

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

abstract class _$NewDetailViewModel
    extends BuildlessAutoDisposeAsyncNotifier<DetailState> {
  late final String detailUrl;
  late final BookSourceEntry bookSource;

  FutureOr<DetailState> build({
    required String detailUrl,
    required BookSourceEntry bookSource,
  });
}

/// 详情搜索
/// 时间 2024-10-1
/// 7-bit
///
/// Copied from [NewDetailViewModel].
@ProviderFor(NewDetailViewModel)
const newDetailViewModelProvider = NewDetailViewModelFamily();

/// 详情搜索
/// 时间 2024-10-1
/// 7-bit
///
/// Copied from [NewDetailViewModel].
class NewDetailViewModelFamily extends Family<AsyncValue<DetailState>> {
  /// 详情搜索
  /// 时间 2024-10-1
  /// 7-bit
  ///
  /// Copied from [NewDetailViewModel].
  const NewDetailViewModelFamily();

  /// 详情搜索
  /// 时间 2024-10-1
  /// 7-bit
  ///
  /// Copied from [NewDetailViewModel].
  NewDetailViewModelProvider call({
    required String detailUrl,
    required BookSourceEntry bookSource,
  }) {
    return NewDetailViewModelProvider(
      detailUrl: detailUrl,
      bookSource: bookSource,
    );
  }

  @override
  NewDetailViewModelProvider getProviderOverride(
    covariant NewDetailViewModelProvider provider,
  ) {
    return call(
      detailUrl: provider.detailUrl,
      bookSource: provider.bookSource,
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
  String? get name => r'newDetailViewModelProvider';
}

/// 详情搜索
/// 时间 2024-10-1
/// 7-bit
///
/// Copied from [NewDetailViewModel].
class NewDetailViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    NewDetailViewModel, DetailState> {
  /// 详情搜索
  /// 时间 2024-10-1
  /// 7-bit
  ///
  /// Copied from [NewDetailViewModel].
  NewDetailViewModelProvider({
    required String detailUrl,
    required BookSourceEntry bookSource,
  }) : this._internal(
          () => NewDetailViewModel()
            ..detailUrl = detailUrl
            ..bookSource = bookSource,
          from: newDetailViewModelProvider,
          name: r'newDetailViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$newDetailViewModelHash,
          dependencies: NewDetailViewModelFamily._dependencies,
          allTransitiveDependencies:
              NewDetailViewModelFamily._allTransitiveDependencies,
          detailUrl: detailUrl,
          bookSource: bookSource,
        );

  NewDetailViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.detailUrl,
    required this.bookSource,
  }) : super.internal();

  final String detailUrl;
  final BookSourceEntry bookSource;

  @override
  FutureOr<DetailState> runNotifierBuild(
    covariant NewDetailViewModel notifier,
  ) {
    return notifier.build(
      detailUrl: detailUrl,
      bookSource: bookSource,
    );
  }

  @override
  Override overrideWith(NewDetailViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: NewDetailViewModelProvider._internal(
        () => create()
          ..detailUrl = detailUrl
          ..bookSource = bookSource,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        detailUrl: detailUrl,
        bookSource: bookSource,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<NewDetailViewModel, DetailState>
      createElement() {
    return _NewDetailViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NewDetailViewModelProvider &&
        other.detailUrl == detailUrl &&
        other.bookSource == bookSource;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, detailUrl.hashCode);
    hash = _SystemHash.combine(hash, bookSource.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NewDetailViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<DetailState> {
  /// The parameter `detailUrl` of this provider.
  String get detailUrl;

  /// The parameter `bookSource` of this provider.
  BookSourceEntry get bookSource;
}

class _NewDetailViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NewDetailViewModel,
        DetailState> with NewDetailViewModelRef {
  _NewDetailViewModelProviderElement(super.provider);

  @override
  String get detailUrl => (origin as NewDetailViewModelProvider).detailUrl;
  @override
  BookSourceEntry get bookSource =>
      (origin as NewDetailViewModelProvider).bookSource;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
