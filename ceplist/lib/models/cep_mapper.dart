import 'package:ceplist/models/cep.dart';
import 'package:ceplist/models/via_cep.dart';

class CepMapper {
  static Cep toCep(ViaCep viaCep) {
    return Cep(
        objectId: "",
        cep: viaCep.cep,
        street: viaCep.street,
        complement: "",
        neighborhood: viaCep.neighborhood,
        city: viaCep.city,
        state: viaCep.state);
  }
}
