// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$readViewModelHash() => r'921d5e25a3cbb1b36f8647eef00b25384f46d7b8';

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

abstract class _$ReadViewModel extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final Chapter chapter1;
  late final BookSourceEntry bookSource;

  FutureOr<void> build({
    required Chapter chapter1,
    required BookSourceEntry bookSource,
  });
}

/// 阅读页面
/// 时间 2024-10-10
/// 7-bit
///
/// Copied from [ReadViewModel].
@ProviderFor(ReadViewModel)
const readViewModelProvider = ReadViewModelFamily();

/// 阅读页面
/// 时间 2024-10-10
/// 7-bit
///
/// Copied from [ReadViewModel].
class ReadViewModelFamily extends Family<AsyncValue<void>> {
  /// 阅读页面
  /// 时间 2024-10-10
  /// 7-bit
  ///
  /// Copied from [ReadViewModel].
  const ReadViewModelFamily();

  /// 阅读页面
  /// 时间 2024-10-10
  /// 7-bit
  ///
  /// Copied from [ReadViewModel].
  ReadViewModelProvider call({
    required Chapter chapter1,
    required BookSourceEntry bookSource,
  }) {
    return ReadViewModelProvider(
      chapter1: chapter1,
      bookSource: bookSource,
    );
  }

  @override
  ReadViewModelProvider getProviderOverride(
    covariant ReadViewModelProvider provider,
  ) {
    return call(
      chapter1: provider.chapter1,
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
  String? get name => r'readViewModelProvider';
}

/// 阅读页面
/// 时间 2024-10-10
/// 7-bit
///
/// Copied from [ReadViewModel].
class ReadViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ReadViewModel, void> {
  /// 阅读页面
  /// 时间 2024-10-10
  /// 7-bit
  ///
  /// Copied from [ReadViewModel].
  ReadViewModelProvider({
    required Chapter chapter1,
    required BookSourceEntry bookSource,
  }) : this._internal(
          () => ReadViewModel()
            ..chapter1 = chapter1
            ..bookSource = bookSource,
          from: readViewModelProvider,
          name: r'readViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$readViewModelHash,
          dependencies: ReadViewModelFamily._dependencies,
          allTransitiveDependencies:
              ReadViewModelFamily._allTransitiveDependencies,
          chapter1: chapter1,
          bookSource: bookSource,
        );

  ReadViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chapter1,
    required this.bookSource,
  }) : super.internal();

  final Chapter chapter1;
  final BookSourceEntry bookSource;

  @override
  FutureOr<void> runNotifierBuild(
    covariant ReadViewModel notifier,
  ) {
    return notifier.build(
      chapter1: chapter1,
      bookSource: bookSource,
    );
  }

  @override
  Override overrideWith(ReadViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReadViewModelProvider._internal(
        () => create()
          ..chapter1 = chapter1
          ..bookSource = bookSource,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chapter1: chapter1,
        bookSource: bookSource,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ReadViewModel, void> createElement() {
    return _ReadViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReadViewModelProvider &&
        other.chapter1 == chapter1 &&
        other.bookSource == bookSource;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chapter1.hashCode);
    hash = _SystemHash.combine(hash, bookSource.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReadViewModelRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `chapter1` of this provider.
  Chapter get chapter1;

  /// The parameter `bookSource` of this provider.
  BookSourceEntry get bookSource;
}

class _ReadViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ReadViewModel, void>
    with ReadViewModelRef {
  _ReadViewModelProviderElement(super.provider);

  @override
  Chapter get chapter1 => (origin as ReadViewModelProvider).chapter1;
  @override
  BookSourceEntry get bookSource =>
      (origin as ReadViewModelProvider).bookSource;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
