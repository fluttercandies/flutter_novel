// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$novelViewModelHash() => r'fb951469bef8e1ec8ce115d265fba7da35ca9e6d';

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

  FutureOr<NovelState> build({
    required String urlNovel,
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
  }) {
    return NovelViewModelProvider(
      urlNovel: urlNovel,
    );
  }

  @override
  NovelViewModelProvider getProviderOverride(
    covariant NovelViewModelProvider provider,
  ) {
    return call(
      urlNovel: provider.urlNovel,
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
  }) : this._internal(
          () => NovelViewModel()..urlNovel = urlNovel,
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
        );

  NovelViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.urlNovel,
  }) : super.internal();

  final String urlNovel;

  @override
  FutureOr<NovelState> runNotifierBuild(
    covariant NovelViewModel notifier,
  ) {
    return notifier.build(
      urlNovel: urlNovel,
    );
  }

  @override
  Override overrideWith(NovelViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: NovelViewModelProvider._internal(
        () => create()..urlNovel = urlNovel,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        urlNovel: urlNovel,
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
    return other is NovelViewModelProvider && other.urlNovel == urlNovel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, urlNovel.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NovelViewModelRef on AutoDisposeAsyncNotifierProviderRef<NovelState> {
  /// The parameter `urlNovel` of this provider.
  String get urlNovel;
}

class _NovelViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NovelViewModel, NovelState>
    with NovelViewModelRef {
  _NovelViewModelProviderElement(super.provider);

  @override
  String get urlNovel => (origin as NovelViewModelProvider).urlNovel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
