class HttpConfig {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";
  //static const String mock = "MOCK";
  static const Duration connectTimeout = Duration(milliseconds: 20 * 1000);
  static const Duration sendTimeout = Duration(milliseconds: 20 * 1000);
  static const Duration receiveTimeout = Duration(milliseconds: 20 * 1000);
}
