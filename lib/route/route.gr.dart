// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:novel_flutter_bit/frame.dart' as _i3;
import 'package:novel_flutter_bit/n_pages/home/view/home_page.dart' as _i4;
import 'package:novel_flutter_bit/n_pages/search/view/search_page.dart' as _i5;
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart'
    as _i10;
import 'package:novel_flutter_bit/pages/book_novel/view/book_page.dart' as _i1;
import 'package:novel_flutter_bit/pages/detail_novel/view/detail_page.dart'
    as _i2;
import 'package:novel_flutter_bit/pages/novel/view/novel_page.dart' as _i6;
import 'package:novel_flutter_bit/pages/search/view/search_page.dart' as _i7;

/// generated route for
/// [_i1.BookPage]
class BookRoute extends _i8.PageRouteInfo<BookRouteArgs> {
  BookRoute({
    _i9.Key? key,
    required String name,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          BookRoute.name,
          args: BookRouteArgs(
            key: key,
            name: name,
          ),
          initialChildren: children,
        );

  static const String name = 'BookRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookRouteArgs>();
      return _i1.BookPage(
        key: args.key,
        name: args.name,
      );
    },
  );
}

class BookRouteArgs {
  const BookRouteArgs({
    this.key,
    required this.name,
  });

  final _i9.Key? key;

  final String name;

  @override
  String toString() {
    return 'BookRouteArgs{key: $key, name: $name}';
  }
}

/// generated route for
/// [_i2.DetailPage]
class DetailRoute extends _i8.PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    _i9.Key? key,
    required _i10.BookDatum bookDatum,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          DetailRoute.name,
          args: DetailRouteArgs(
            key: key,
            bookDatum: bookDatum,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailRouteArgs>();
      return _i2.DetailPage(
        key: args.key,
        bookDatum: args.bookDatum,
      );
    },
  );
}

class DetailRouteArgs {
  const DetailRouteArgs({
    this.key,
    required this.bookDatum,
  });

  final _i9.Key? key;

  final _i10.BookDatum bookDatum;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, bookDatum: $bookDatum}';
  }
}

/// generated route for
/// [_i3.FramePage]
class FrameRoute extends _i8.PageRouteInfo<void> {
  const FrameRoute({List<_i8.PageRouteInfo>? children})
      : super(
          FrameRoute.name,
          initialChildren: children,
        );

  static const String name = 'FrameRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.FramePage();
    },
  );
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomePage();
    },
  );
}

/// generated route for
/// [_i5.NewSearchPage]
class NewSearchRoute extends _i8.PageRouteInfo<NewSearchRouteArgs> {
  NewSearchRoute({
    _i9.Key? key,
    required String searchKey,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          NewSearchRoute.name,
          args: NewSearchRouteArgs(
            key: key,
            searchKey: searchKey,
          ),
          initialChildren: children,
        );

  static const String name = 'NewSearchRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewSearchRouteArgs>();
      return _i5.NewSearchPage(
        key: args.key,
        searchKey: args.searchKey,
      );
    },
  );
}

class NewSearchRouteArgs {
  const NewSearchRouteArgs({
    this.key,
    required this.searchKey,
  });

  final _i9.Key? key;

  final String searchKey;

  @override
  String toString() {
    return 'NewSearchRouteArgs{key: $key, searchKey: $searchKey}';
  }
}

/// generated route for
/// [_i6.NovelPage]
class NovelRoute extends _i8.PageRouteInfo<NovelRouteArgs> {
  NovelRoute({
    _i9.Key? key,
    required String url,
    required String name,
    required _i10.BookDatum bookDatum,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          NovelRoute.name,
          args: NovelRouteArgs(
            key: key,
            url: url,
            name: name,
            bookDatum: bookDatum,
          ),
          initialChildren: children,
        );

  static const String name = 'NovelRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NovelRouteArgs>();
      return _i6.NovelPage(
        key: args.key,
        url: args.url,
        name: args.name,
        bookDatum: args.bookDatum,
      );
    },
  );
}

class NovelRouteArgs {
  const NovelRouteArgs({
    this.key,
    required this.url,
    required this.name,
    required this.bookDatum,
  });

  final _i9.Key? key;

  final String url;

  final String name;

  final _i10.BookDatum bookDatum;

  @override
  String toString() {
    return 'NovelRouteArgs{key: $key, url: $url, name: $name, bookDatum: $bookDatum}';
  }
}

/// generated route for
/// [_i7.SearchPage]
class SearchRoute extends _i8.PageRouteInfo<void> {
  const SearchRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SearchPage();
    },
  );
}
