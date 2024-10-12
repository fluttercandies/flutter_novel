// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$readViewModelHash() => r'091654eeed96a6b329ddf6d57b63550601c5ebbb';

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

abstract class _$ReadViewModel
    extends BuildlessAutoDisposeAsyncNotifier<ReadState> {
  late final Chapter chapter1;
  late final BookSourceEntry bookSource;
  late final List<Chapter>? chapterList;

  FutureOr<ReadState> build({
    required Chapter chapter1,
    required BookSourceEntry bookSource,
    List<Chapter>? chapterList,
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
class ReadViewModelFamily extends Family<AsyncValue<ReadState>> {
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
    List<Chapter>? chapterList,
  }) {
    return ReadViewModelProvider(
      chapter1: chapter1,
      bookSource: bookSource,
      chapterList: chapterList,
    );
  }

  @override
  ReadViewModelProvider getProviderOverride(
    covariant ReadViewModelProvider provider,
  ) {
    return call(
      chapter1: provider.chapter1,
      bookSource: provider.bookSource,
      chapterList: provider.chapterList,
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
    extends AutoDisposeAsyncNotifierProviderImpl<ReadViewModel, ReadState> {
  /// 阅读页面
  /// 时间 2024-10-10
  /// 7-bit
  ///
  /// Copied from [ReadViewModel].
  ReadViewModelProvider({
    required Chapter chapter1,
    required BookSourceEntry bookSource,
    List<Chapter>? chapterList,
  }) : this._internal(
          () => ReadViewModel()
            ..chapter1 = chapter1
            ..bookSource = bookSource
            ..chapterList = chapterList,
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
          chapterList: chapterList,
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
    required this.chapterList,
  }) : super.internal();

  final Chapter chapter1;
  final BookSourceEntry bookSource;
  final List<Chapter>? chapterList;

  @override
  FutureOr<ReadState> runNotifierBuild(
    covariant ReadViewModel notifier,
  ) {
    return notifier.build(
      chapter1: chapter1,
      bookSource: bookSource,
      chapterList: chapterList,
    );
  }

  @override
  Override overrideWith(ReadViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReadViewModelProvider._internal(
        () => create()
          ..chapter1 = chapter1
          ..bookSource = bookSource
          ..chapterList = chapterList,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chapter1: chapter1,
        bookSource: bookSource,
        chapterList: chapterList,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ReadViewModel, ReadState>
      createElement() {
    return _ReadViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReadViewModelProvider &&
        other.chapter1 == chapter1 &&
        other.bookSource == bookSource &&
        other.chapterList == chapterList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chapter1.hashCode);
    hash = _SystemHash.combine(hash, bookSource.hashCode);
    hash = _SystemHash.combine(hash, chapterList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReadViewModelRef on AutoDisposeAsyncNotifierProviderRef<ReadState> {
  /// The parameter `chapter1` of this provider.
  Chapter get chapter1;

  /// The parameter `bookSource` of this provider.
  BookSourceEntry get bookSource;

  /// The parameter `chapterList` of this provider.
  List<Chapter>? get chapterList;
}

class _ReadViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ReadViewModel, ReadState>
    with ReadViewModelRef {
  _ReadViewModelProviderElement(super.provider);

  @override
  Chapter get chapter1 => (origin as ReadViewModelProvider).chapter1;
  @override
  BookSourceEntry get bookSource =>
      (origin as ReadViewModelProvider).bookSource;
  @override
  List<Chapter>? get chapterList =>
      (origin as ReadViewModelProvider).chapterList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
