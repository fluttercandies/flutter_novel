import 'package:dio/dio.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';

class NovelHttp {
  Dio? _dio;

  /// 私有构造
  NovelHttp._();

  /// 实例化Http
  factory NovelHttp() => _instance;

  /// 初始化配置
  static final NovelHttp _instance = NovelHttp._internal();

  /// 通用全局单例，第一次使用时初始化
  NovelHttp._internal() {
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
    String baseUrl = "https://api.book.bbdaxia.com/";
    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: HttpConfig.connectTimeout,
      receiveTimeout: HttpConfig.receiveTimeout,
      //headers: httpHeaders,
    );
  }

  /// get请求
  ///
  /// [path] 必传，请求路径
  /// [params] 非必传，请求入参
  Future<ServiceResultData?> _get<T>(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    params = params ?? {};
    ServiceResultData? resultData;
    try {
      Response? response = await _dio?.get(path, queryParameters: params);
      var responseData = response?.data;
      resultData = ServiceResultData<T>.fromJson(responseData);
      //_handleStatusCode(responseModel);
    } on DioException catch (dioError, _) {
      //_handleError(dioError, e);
      LoggerTools.looger.e(dioError.message);
      if (dioError.requestOptions.cancelToken is CancelToken) {
        resultData = ServiceResultData(data: null, code: -1, msg: '取消请求');
      }
      // else {
      //   if (dioError.response!.data is Map) {
      //     responseModel = ResponseModel(
      //         data: null,
      //         code: dioError.response!.data['code'],
      //         message: '网络异常');
      //   } else {
      //     responseModel = ResponseModel(data: null, code: 404, message: '网络异常');
      //   }
      // }
      // if (dioError is TimeoutException) {
      //   responseModel = ResponseModel(data: null, code: -100, message: '网络超时');
      // }
    }
    return resultData;
  }
}
