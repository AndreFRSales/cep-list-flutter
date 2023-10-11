import 'package:ceplist/models/via_cep.dart';
import 'package:dio/dio.dart';

class ViaCepRepository {
  final _dio = Dio();

  Future<ViaCep> fetchCep(String cep) async {
    try {
      var response = await _dio.get("https://viacep.com.br/ws/$cep/json/");
      var cepResponse = ViaCep.fromJson(response.data);
      return cepResponse;
    } catch (e) {
      return ViaCep.empty();
    }
  }
}
