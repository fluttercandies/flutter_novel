import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';

class NewNovelHttp {
  Dio? _dio;

  /// 私有构造
  NewNovelHttp._();

  /// 实例化Http
  factory NewNovelHttp() => _instance;

  /// 初始化配置
  static final NewNovelHttp _instance = NewNovelHttp._internal();

  /// 通用全局单例，第一次使用时初始化
  NewNovelHttp._internal() {
    if (_dio == null) {
      // 初始化dio
      _dio = Dio(_options());
      // 拦截器
      _dio?.interceptors.add(_interceptors());
    }
  }

  /// 获取拦截器
  InterceptorsWrapper _interceptors() {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        return handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        return handler.next(e);
      },
    );
  }

  /// 获取基础配置项
  BaseOptions _options() {
    // 获取当前环境对应的配置项
    //String baseUrl = "https://api.book.bbdaxia.com/";
    return BaseOptions(
        // baseUrl: baseUrl,
        connectTimeout: HttpConfig.connectTimeout,
        receiveTimeout: HttpConfig.receiveTimeout,
        responseType: ResponseType.bytes
        //headers: httpHeaders,
        );
  }

  /// get请求
  ///
  /// [path] 必传，请求路径
  /// [params] 非必传，请求入参
  Future<ServiceResultData> _get(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    params = params ?? {};
    LoggerTools.looger.d('get请求URL：$path');
    LoggerTools.looger.d('get请求Params：$params');
    ServiceResultData? resultData;
    try {
      Response? response = await _dio?.get(path, queryParameters: params);
      var responseData = response?.data;
      resultData = ServiceResultData.fromJson(responseData);
      //_handleStatusCode(responseModel);
    } on DioException catch (dioError, _) {
      //_handleError(dioError, e);
      LoggerTools.looger.e(dioError.message);
      if (dioError.requestOptions.cancelToken is CancelToken) {
        resultData = ServiceResultData(data: null, code: -1, msg: '取消请求');
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        resultData =
            ServiceResultData(data: null, code: 504, msg: '服务器维护中，请稍后重试');
      } else {
        resultData = ServiceResultData(data: null, code: 404, msg: '网络异常');
      }
      if (dioError is TimeoutException) {
        resultData = ServiceResultData(data: null, code: -100, msg: '网络超时');
      }
    }
    return resultData;
  }

  /// post请求
  ///
  /// [path] 必传，请求路径
  /// [params] 非必传，请求入参
  Future<ServiceResultData> _post(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    ServiceResultData? responseModel;
    LoggerTools.looger.d('post请求URL：$path');
    LoggerTools.looger.d('post请求Params：$params');
    try {
      Response? response = await _dio?.post(path, data: params);
      var responseData = response?.data;
      responseModel = ServiceResultData.fromJson(responseData);
    } on DioException catch (dioError, _) {
      responseModel = ServiceResultData(
          data: null, code: dioError.response!.data['code'], msg: '网络异常');
      if (dioError is TimeoutException) {
        responseModel = ServiceResultData(data: null, code: -100, msg: '网络超时');
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        responseModel =
            ServiceResultData(data: null, code: 504, msg: '服务器维护中，请稍后重试');
      }
    }
    return responseModel;
  }

  /// 发起请求
  /// [path] 请求链接
  /// [params] 请求参数
  /// [method] 请求方式
  Future<ServiceResultData> request(
    String path, {
    Map<String, dynamic>? params,
    String method = HttpConfig.get,
  }) async {
    params = params ?? {};
    if (method == HttpConfig.get) {
      return await _get(path, params: params);
    } else if (method == HttpConfig.post) {
      return await _post(path, params: params);
    } else {
      throw HttpException('request method $method is not support');
    }
  }
}
