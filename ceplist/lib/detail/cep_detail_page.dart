import 'package:ceplist/models/cep.dart';
import 'package:ceplist/repositories/ceplist/cep_repository.dart';
import 'package:flutter/material.dart';

class CepDetailPage extends StatefulWidget {
  String cep;
  CepDetailPage({super.key, required this.cep});

  @override
  State<CepDetailPage> createState() => _CepDetailPageState();
}

class _CepDetailPageState extends State<CepDetailPage> {
  var streetController = TextEditingController();
  var complementController = TextEditingController();
  var neighborhoodController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var cepRepository = CepRepository();
  Cep cep = Cep.empty();
  var loading = false;

  @override
  void initState() {
    fetchCep();
    super.initState();
  }

  fetchCep() async {
    cep = await cepRepository.fetchCep(widget.cep);
    streetController.text = cep.cep;
    complementController.text = cep.complement;
    neighborhoodController.text = cep.neighborhood;
    cityController.text = cep.city;
    stateController.text = cep.state;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.cep),
        ),
        body: ListView(children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: TextField(
                  controller: streetController,
                  decoration: const InputDecoration(
                    hintText: "Rua",
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: TextField(
                    controller: complementController,
                    decoration: const InputDecoration(
                      hintText: "Complemento",
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: TextField(
                    controller: neighborhoodController,
                    decoration: const InputDecoration(
                      hintText: "Bairro",
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      hintText: "Cidade",
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: TextField(
                    controller: stateController,
                    decoration: const InputDecoration(
                      hintText: "UF",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: loading
                      ? const SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : TextButton(
                          onPressed: () async {
                            loading = true;
                            setState(() {});
                            if (streetController.text.isNotEmpty &&
                                neighborhoodController.text.isNotEmpty &&
                                cityController.text.isNotEmpty &&
                                stateController.text.isNotEmpty) {
                              await cepRepository.updateCep(Cep(
                                  objectId: cep.objectId,
                                  cep: cep.cep,
                                  street: streetController.text,
                                  complement: complementController.text,
                                  neighborhood: neighborhoodController.text,
                                  city: cityController.text,
                                  state: stateController.text));
                              const snackBar = SnackBar(
                                content:
                                    Text('Endereço atualizado com sucesso!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            loading = false;
                            setState(() {});
                          },
                          child: const Text("Atualizar")),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
