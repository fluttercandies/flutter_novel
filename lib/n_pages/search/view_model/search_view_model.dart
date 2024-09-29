import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
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
    final data =
        parseAllMatches(bookSourceEntry.ruleSearch!.author!, resultData.data);
    final data1 =
        parseAllMatches(bookSourceEntry.ruleSearch!.bookUrl!, resultData.data);
    final data2 =
        parseAllMatches(bookSourceEntry.ruleSearch!.bookList!, resultData.data);
    final data3 =
        parseAllMatches(bookSourceEntry.ruleSearch!.coverUrl!, resultData.data);
    final data4 = parseAllMatches(
        bookSourceEntry.ruleSearch!.lastChapter!, resultData.data);
    final data5 =
        parseAllMatches(bookSourceEntry.ruleSearch!.name!, resultData.data);
    LoggerTools.looger.d(data.toString());
    LoggerTools.looger.d(data1.toString());
    LoggerTools.looger.d(data2.toString());
    LoggerTools.looger.d(data3.toString());
  }

  /// 通用规则解析方法，返回所有符合条件的匹配项
  List<String?> parseAllMatches(String rule, String htmlData) {
    // 解析 HTML 数据
    Document document = parse(htmlData);

    // 解析规则字符串
    List<String> parts = rule.split('@');
    String rootPart = parts[0]; // 获取第一个部分，比如 "id.info" 或 "class.s4"
    List<Element>? elements = [];

    // 解析 root 部分 (id 或 class)
    if (rootPart.startsWith('id.')) {
      String id = rootPart.split('.')[1];
      Element? element = document.getElementById(id);
      if (element != null) {
        elements = [element]; // 将初始元素添加到列表中
      }
    } else if (rootPart.startsWith('class.')) {
      String className = rootPart.split('.')[1];
      elements = document.getElementsByClassName(className).toList();
    }

    if (elements.isEmpty) {
      print('Root element not found for $rootPart');
      return [];
    }

    // 逐步解析标签和属性
    for (int i = 1; i < parts.length; i++) {
      String part = parts[i];
      List<Element> newElements = [];

      // 解析标签部分
      if (part.startsWith('tag.')) {
        List<String> tagParts = part.split('.');
        String tagName = tagParts[1];
        int? index = tagParts.length > 2 ? int.tryParse(tagParts[2]) : null;

        // 针对每个当前元素，获取其子元素
        for (var element in elements!) {
          List<Element> children =
              element.getElementsByTagName(tagName).toList();
          if (index != null && children.length > index) {
            newElements.add(children[index]);
          } else if (index == null) {
            newElements.addAll(children); // 没有索引时，添加所有子元素
          }
        }
        elements = newElements;
      }
      // 提取属性或文本内容
      else if (part == 'text') {
        return elements!.map((e) => e.text).toList();
      } else if (part == 'href' || part == 'src') {
        return elements!.map((e) => e.attributes[part]).toList();
      }
    }

    return elements!.map((e) => e.text).toList(); // 如果未明确指定获取文本，则返回所有匹配的文本内容
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
