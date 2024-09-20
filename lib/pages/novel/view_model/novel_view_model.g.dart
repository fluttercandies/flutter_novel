// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$novelViewModelHash() => r'6c45951446e5037a1f01bc5d7c5e34dd44b80ea0';

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

abstract class _$NovelViewModel
    extends BuildlessAutoDisposeAsyncNotifier<NovelState> {
  late final String urlNovel;
  late final NovleHistoryEntry novleHistory;

  FutureOr<NovelState> build({
    required String urlNovel,
    required NovleHistoryEntry novleHistory,
  });
}

/// See also [NovelViewModel].
@ProviderFor(NovelViewModel)
const novelViewModelProvider = NovelViewModelFamily();

/// See also [NovelViewModel].
class NovelViewModelFamily extends Family<AsyncValue<NovelState>> {
  /// See also [NovelViewModel].
  const NovelViewModelFamily();

  /// See also [NovelViewModel].
  NovelViewModelProvider call({
    required String urlNovel,
    required NovleHistoryEntry novleHistory,
  }) {
    return NovelViewModelProvider(
      urlNovel: urlNovel,
      novleHistory: novleHistory,
    );
  }

  @override
  NovelViewModelProvider getProviderOverride(
    covariant NovelViewModelProvider provider,
  ) {
    return call(
      urlNovel: provider.urlNovel,
      novleHistory: provider.novleHistory,
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
  String? get name => r'novelViewModelProvider';
}

/// See also [NovelViewModel].
class NovelViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<NovelViewModel, NovelState> {
  /// See also [NovelViewModel].
  NovelViewModelProvider({
    required String urlNovel,
    required NovleHistoryEntry novleHistory,
  }) : this._internal(
          () => NovelViewModel()
            ..urlNovel = urlNovel
            ..novleHistory = novleHistory,
          from: novelViewModelProvider,
          name: r'novelViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$novelViewModelHash,
          dependencies: NovelViewModelFamily._dependencies,
          allTransitiveDependencies:
              NovelViewModelFamily._allTransitiveDependencies,
          urlNovel: urlNovel,
          novleHistory: novleHistory,
        );

  NovelViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.urlNovel,
    required this.novleHistory,
  }) : super.internal();

  final String urlNovel;
  final NovleHistoryEntry novleHistory;

  @override
  FutureOr<NovelState> runNotifierBuild(
    covariant NovelViewModel notifier,
  ) {
    return notifier.build(
      urlNovel: urlNovel,
      novleHistory: novleHistory,
    );
  }

  @override
  Override overrideWith(NovelViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: NovelViewModelProvider._internal(
        () => create()
          ..urlNovel = urlNovel
          ..novleHistory = novleHistory,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        urlNovel: urlNovel,
        novleHistory: novleHistory,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<NovelViewModel, NovelState>
      createElement() {
    return _NovelViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NovelViewModelProvider &&
        other.urlNovel == urlNovel &&
        other.novleHistory == novleHistory;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, urlNovel.hashCode);
    hash = _SystemHash.combine(hash, novleHistory.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NovelViewModelRef on AutoDisposeAsyncNotifierProviderRef<NovelState> {
  /// The parameter `urlNovel` of this provider.
  String get urlNovel;

  /// The parameter `novleHistory` of this provider.
  NovleHistoryEntry get novleHistory;
}

class _NovelViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NovelViewModel, NovelState>
    with NovelViewModelRef {
  _NovelViewModelProviderElement(super.provider);

  @override
  String get urlNovel => (origin as NovelViewModelProvider).urlNovel;
  @override
  NovleHistoryEntry get novleHistory =>
      (origin as NovelViewModelProvider).novleHistory;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
