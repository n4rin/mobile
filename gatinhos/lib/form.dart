import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gatinhos/gato-repository.dart';
import 'package:gatinhos/gato.dart';

class FormGatito extends StatefulWidget {
  const FormGatito({super.key});

  @override
  State<FormGatito> createState() => _FormGatitoState();
}

class _FormGatitoState extends State<FormGatito> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtNome = TextEditingController();
    TextEditingController txtIdade = TextEditingController();
    TextEditingController txtRaca = TextEditingController();
    TextEditingController txtDono = TextEditingController();
    TextEditingController txtImagem = TextEditingController();
    List<Gato> gatosReg = GatoRepository.getGatos;
    String imagem =
        "https://cdn.pixabay.com/photo/2020/04/15/13/33/tiger-5046610_1280.png";

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Gatito"),
      ),
      body: Container(
          color: Color.fromARGB(255, 92, 89, 177),
          height: MediaQuery.sizeOf(context).height,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        child: Icon(
                          Icons.pets,
                          size: 175,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: txtImagem,
                              decoration: InputDecoration(
                                labelText: "Link Imagem",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            validator: (value) {
                              if (value == "" ||
                                  value == null ||
                                  value.isEmpty) {
                                return "Campo Obrigatório";
                              } else if (value.length < 3) {
                                return "CNome deve ter no mínimo 3 caracteres";
                              }
                              return null;
                            },
                            controller: txtNome,
                            decoration: InputDecoration(
                              labelText: "Nome",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value == "" ||
                                  value == null ||
                                  value.isEmpty) {
                                return "Campo Obrigatório";
                              } else if (int.parse(value) < 1) {
                                return "A idade deve ser maior que 1";
                              }
                              return null;
                            },
                            controller: txtIdade,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Idade",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                      ]),
                      TextFormField(
                        validator: (value) {
                          if (value == "" || value == null || value.isEmpty) {
                            return "Campo Obrigatório";
                          } else if (value.length < 3) {
                            return "Raça deve ter no mínimo 3 caracteres";
                          }
                          return null;
                        },
                        controller: txtRaca,
                        decoration: InputDecoration(
                          labelText: "Raça",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == "" || value == null || value.isEmpty) {
                            return "Campo Obrigatório";
                          } else if (value.length < 3) {
                            return "Nome do dono deve ter no mínimo 3 caracteres";
                          }
                          return null;
                        },
                        controller: txtDono,
                        decoration: InputDecoration(
                          labelText: "Dono",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (txtImagem.text.trim().isEmpty ||
                                  txtImagem.text.trim() == "" ||
                                  txtImagem.text.trim() == null) {
                                GatoRepository().adicionar(Gato(
                                    geraId(),
                                    imagem,
                                    txtNome.text.trim(),
                                    txtRaca.text.trim(),
                                    int.parse(txtIdade.text.trim()),
                                    txtDono.text.trim()));
                              } else {
                                GatoRepository().adicionar(Gato(
                                    geraId(),
                                    txtImagem.text.trim(),
                                    txtNome.text.trim(),
                                    txtRaca.text.trim(),
                                    int.parse(txtIdade.text.trim()),
                                    txtDono.text.trim()));
                              }
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Cadastrar Gatito"))
                    ],
                  ),
                )),
          )),
    );
  }
}

int geraId() {
  bool existe = false;
  int id = Random().nextInt(999);
  List gatos = GatoRepository.getGatos;
  while (existe == true) {
    existe = false;
    for (var i = 0; i < gatos.length; i++) {
      if (gatos[i].id == id) {
        existe == true;
        break;
      }
    }
  }
  return id;
}
