class ViaCep {
  String cep = "";
  String street = "";
  String complement = "";
  String neighborhood = "";
  String city = "";
  String state = "";

  ViaCep(this.cep, this.street, this.complement, this.neighborhood, this.city,
      this.state);

  ViaCep.empty() {
    cep = "";
    street = "";
    complement = "";
    neighborhood = "";
    city = "";
    state = "";
  }

  ViaCep.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    street = json['logradouro'];
    complement = json['complemento'];
    neighborhood = json['bairro'];
    city = json['localidade'];
    state = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = street;
    data['complemento'] = complement;
    data['bairro'] = neighborhood;
    data['localidade'] = city;
    data['uf'] = state;
    return data;
  }
}
