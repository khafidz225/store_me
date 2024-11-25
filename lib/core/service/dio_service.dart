import 'package:dio/dio.dart';

import '../interceptor/app_interceptor.dart';

class DioService {
  final Dio _dio;
  DioService(this._dio) {
    _dio.options = BaseOptions();
    _dio.interceptors.addAll([
      AppInterceptor(),
    ]);
  }

  get dio => _dio;
}
