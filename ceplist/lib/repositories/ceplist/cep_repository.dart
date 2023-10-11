import 'package:ceplist/models/cep.dart';
import 'package:ceplist/repositories/network/ceplist_dio.dart';
import 'package:dio/dio.dart';

class CepRepository {
  final _cepListDio = CepListDio();

  Future<List<Cep>> fetchCeps() async {
    var response = await _cepListDio.dio.get("/Ceps");
    if (_isResponseSuccess(response)) {
      var result = response.data['results'];
      return (result as List).map((e) => Cep.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<Cep> fetchCep(String cep) async {
    var query = "?where={\"cep\": \"$cep\"}";
    var response = await _cepListDio.dio.get("/Ceps$query");
    var firstResult = (response.data['results'] as List).firstOrNull;
    if (_isResponseSuccess(response)) {
      return Cep.fromJson(firstResult);
    } else {
      return Cep.empty();
    }
  }

  saveCep(Cep cep) async {
    try {
      await _cepListDio.dio.post("/Ceps", data: cep.toJson());
    } catch (e) {
      e.toString();
    }
  }

  updateCep(Cep cep) async {
    try {
      await _cepListDio.dio.put("/Ceps/${cep.objectId}", data: cep.toJson());
    } catch (e) {
      e.toString();
    }
  }

  bool _isResponseSuccess(Response response) {
    return (response.statusCode ?? 0) >= 200 &&
        (response.statusCode ?? 0) <= 299;
  }
}
