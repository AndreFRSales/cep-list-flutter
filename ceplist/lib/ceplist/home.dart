import 'package:ceplist/detail/cep_detail_page.dart';
import 'package:ceplist/models/cep.dart';
import 'package:ceplist/models/cep_mapper.dart';
import 'package:ceplist/repositories/ceplist/cep_repository.dart';
import 'package:ceplist/repositories/viacep/via_cep_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var cepController = TextEditingController();
  var cepListRepository = CepRepository();
  var viaCepRepository = ViaCepRepository();
  var cepsList = <Cep>[];
  String? cepNotFound;
  var loading = false;

  @override
  void initState() {
    fetchCeps();
    super.initState();
  }

  fetchCeps() async {
    setState(() {
      loading = true;
    });
    cepsList = await cepListRepository.fetchCeps();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Lista de CEPs"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: loading
              ? const Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                )
              : Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                        controller: cepController,
                        keyboardType: TextInputType.number,
                        maxLength: 8,
                        decoration: InputDecoration(
                            hintText: "Digite o CEP", errorText: cepNotFound),
                        onChanged: (value) async {
                          String cep =
                              value.trim().replaceAll(RegExp(r'[^0-9]'), '');
                          if (value.trim().length == 8) {
                            var cepResult =
                                await viaCepRepository.fetchCep(cep);
                            var cepMapped = CepMapper.toCep(cepResult);
                            var firstWhere = cepsList
                                .where(
                                    (element) => element.cep == cepMapped.cep)
                                .firstOrNull;
                            if (firstWhere == null &&
                                cepMapped.street.isNotEmpty) {
                              await cepListRepository.saveCep(cepMapped);
                              cepsList.add(cepMapped);
                              setState(() {});
                            } else if (cepMapped.cep.isEmpty) {
                              setState(() {
                                cepNotFound = "Cep não encontrado!";
                              });
                            }
                          } else {
                            setState(() {
                              cepNotFound = null;
                            });
                          }
                        }),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: cepsList.length,
                          itemBuilder: (context, index) {
                            var value = cepsList[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CepDetailPage(cep: value.cep);
                                }));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(value.cep.toString()),
                                  ),
                                  const Divider()
                                ],
                              ),
                            );
                          }))
                ]),
        ),
      ),
    );
  }
}
