import 'package:ceplist/repositories/network/ceplist_interceptor.dart';
import 'package:dio/dio.dart';

class CepListDio {
  final _dio = Dio();

  CepListDio() {
    _dio.options.baseUrl = "https://parseapi.back4app.com/classes/";
    _dio.interceptors.add(CepListInterceptor());
  }

  Dio get dio => _dio;
}
