import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gbk2utf8/flutter_gbk2utf8.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:novel_flutter_bit/pages/new_home/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  /// 加载书籍源
  Future<BookSourceEntry> loadBookSourceEntry() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/source.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return BookSourceEntry.fromJson(jsonMap);
  }

  // GBK URL 编码函数
  String toGbkUrlEncoded(String input) {
    List<int> gbkBytes = gbk.encode(input);
    StringBuffer encoded = StringBuffer();
    for (var byte in gbkBytes) {
      encoded.write('%${byte.toRadixString(16).toUpperCase().padLeft(2, '0')}');
    }
    return encoded.toString();
  }

// UTF-8 URL 编码函数（Dart 原生支持）
  String toUtf8UrlEncoded(String input) {
    return Uri.encodeComponent(input);
  }

  String key = "斗破苍穹";
  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    _sourceEntry = await loadBookSourceEntry();

    _dio = Dio(BaseOptions(
        headers: json.decode(_sourceEntry.header ?? "{}"),
        responseType: ResponseType.bytes));
    // 从模板中提取 charset
    RegExp charsetPattern = RegExp(r'"charset":\s*"([^"]+)"');
    var match = charsetPattern.firstMatch(_sourceEntry.searchUrl ?? "");
    String charset =
        match != null ? match.group(1) ?? 'utf-8' : 'utf-8'; // 默认utf-8

    // 根据 charset 选择编码方式
    String encodedKey;
    if (charset.toLowerCase() == 'gbk') {
      encodedKey = toGbkUrlEncoded(key); // 使用 GBK 编码
    } else if (charset.toLowerCase() == 'utf-8') {
      encodedKey = toUtf8UrlEncoded(key); // 使用 UTF-8 编码
    } else {
      throw UnsupportedError('不支持的编码格式: $charset');
    }

    // 替换 searchUrl 中的 {{key}} 占位符
    String finalUrl = _sourceEntry.searchUrl!.replaceAll('{{key}}', encodedKey);

    // 去掉 charset 部分
    String cleanUrl = finalUrl.split(',')[0]; // 只保留 "," 前面的部分
    final Response data =
        await _dio.get("${_sourceEntry.bookSourceUrl}$cleanUrl");

    var url = Uri.parse('${_sourceEntry.bookSourceUrl}$cleanUrl');
    var response = await http.get(url);
// 将字符串转换为字节，然后进行 GBK 解码
    final z = gbk.decode(data.data);
    print("========   |  ");
    // writeToLocalFile(z);
    //List<int> bytes = data.data!.codeUnits;
    Document document = parse(z);
    // final a = gbk.decode(bytes);
    // final b = parse(data.data, encoding: "gbk");
    // final d = parse(data.data, encoding: "utf-8");
    var c = document.getElementsByTagName("title");
    for (var data1 in c) {
      SmartDialog.showToast(data1.text);
    }
    //
    // print(b.body);
    // print(b.body);
  }

  Future<void> writeToLocalFile(String content) async {
    // 获取文档目录
    final Directory docsDir = await getApplicationDocumentsDirectory();
    // 创建文件
    final File file = File('${docsDir.path}/example.txt');
    print(file.path);
    // 写入内容

    await file.writeAsString(content);
  }

  late BookSourceEntry _sourceEntry;
  late Dio _dio;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
