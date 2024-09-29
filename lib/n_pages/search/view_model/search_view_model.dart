import 'dart:convert';

import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/net/new_novel_http.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_gbk2utf8/flutter_gbk2utf8.dart';
part 'search_view_model.g.dart';

@riverpod
class NewSearchViewModel extends _$NewSearchViewModel {
  @override
  Future<void> build(
      {required String searchKey,
      required BookSourceEntry bookSourceEntry}) async {
    LoggerTools.looger.d("NEW HomeViewModel init build");
    _initData(searchKey: searchKey, bookSourceEntry: bookSourceEntry);
  }

  void _initData({
    required String searchKey,
    required BookSourceEntry bookSourceEntry,
  }) async {
    final resultData = await NewNovelHttp().request(
        "${bookSourceEntry.bookSourceUrl}${_getSearchUrl(searchKey: searchKey, searchUrl: bookSourceEntry.searchUrl ?? "")}");
    resultData.data = gbk.decode(resultData.data);
    LoggerTools.looger.d(resultData.data);
  }

  String _getSearchUrl({required String searchKey, required String searchUrl}) {
    // 从模板中提取 charset
    RegExp charsetPattern = RegExp(r'"charset":\s*"([^"]+)"');
    var match = charsetPattern.firstMatch(searchUrl);
    String charset =
        match != null ? match.group(1) ?? 'utf-8' : 'utf-8'; // 默认utf-8

    // 根据 charset 选择编码方式
    String encodedKey;
    if (charset.toLowerCase() == 'gbk') {
      encodedKey = toGbkUrlEncoded(searchKey); // 使用 GBK 编码
    } else if (charset.toLowerCase() == 'utf-8') {
      encodedKey = toUtf8UrlEncoded(searchKey); // 使用 UTF-8 编码
    } else {
      throw UnsupportedError('不支持的编码格式: $charset');
    }

    // 替换 searchUrl 中的 {{key}} 占位符
    String finalUrl = searchUrl.replaceAll('{{key}}', encodedKey);

    // 去掉 charset 部分
    String cleanUrl = finalUrl.split(',')[0]; // 只保留 "," 前面的部分
    // final Response<String> data =
    //     await _dio.get("${_sourceEntry.bookSourceUrl}$cleanUrl");
    return cleanUrl;
  }

  // 对字符串进行 GBK URL 编码
  String toGbkUrlEncoded(String input) {
    List<int> gbkBytes = gbk.encode(input); // 将字符串转换为GBK字节
    return gbkBytes
        .map((byte) =>
            '%${byte.toRadixString(16).padLeft(2, '0').toUpperCase()}')
        .join();
  }

// 对字符串进行 UTF-8 URL 编码
  String toUtf8UrlEncoded(String input) {
    List<int> utf8Bytes = utf8.encode(input); // 将字符串转换为UTF-8字节
    return utf8Bytes
        .map((byte) =>
            '%${byte.toRadixString(16).padLeft(2, '0').toUpperCase()}')
        .join();
  }
}
