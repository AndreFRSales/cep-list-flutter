class Cep {
  String objectId = "";
  String cep = "";
  String street = "";
  String complement = "";
  String neighborhood = "";
  String city = "";
  String state = "";

  Cep(
      {required this.objectId,
      required this.cep,
      required this.street,
      required this.complement,
      required this.neighborhood,
      required this.city,
      required this.state});

  Cep.empty() {
    objectId = "";
    cep = "";
    street = "";
    complement = "";
    neighborhood = "";
    city = "";
    state = "";
  }

  Cep.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'] ?? "";
    cep = json['cep'];
    street = json['street'];
    complement = json['complement'] ?? "";
    neighborhood = json['neighborhood'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['street'] = street;
    data['complement'] = complement;
    data['neighborhood'] = neighborhood;
    data['city'] = city;
    data['state'] = state;
    return data;
  }
}
