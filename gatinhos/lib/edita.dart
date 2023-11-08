import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gatinhos/gato-repository.dart';
import 'package:gatinhos/gato.dart';

class EditaGatito extends StatefulWidget {
  Gato gatoEditar;

  EditaGatito(this.gatoEditar, {super.key});

  @override
  State<EditaGatito> createState() => _EditaGatitoState();
}

class _EditaGatitoState extends State<EditaGatito> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtNome = TextEditingController();
    TextEditingController txtIdade = TextEditingController();
    TextEditingController txtRaca = TextEditingController();
    TextEditingController txtDono = TextEditingController();
    TextEditingController txtImagem = TextEditingController();

    String imagem = widget.gatoEditar.imagem;
    int id = widget.gatoEditar.id;

    txtImagem.text = widget.gatoEditar.imagem;
    txtNome.text = widget.gatoEditar.nome;
    txtIdade.text = widget.gatoEditar.idade.toString();
    txtRaca.text = widget.gatoEditar.raca;
    txtDono.text = widget.gatoEditar.dono;

    List listaGatos = GatoRepository.getGatos;

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Gatito"),
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
                        child: Image.network(imagem),
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
                            txtDono.text.trim();
                            txtImagem.text = txtImagem.text.trim();
                            txtNome.text = txtNome.text.trim();
                            txtRaca.text = txtRaca.text.trim();
                            txtIdade.text = txtIdade.text.trim();
                            if (_formKey.currentState!.validate()) {
                              if (txtImagem.text.trim().isEmpty ||
                                  txtImagem.text.trim() == "" ||
                                  txtImagem.text.trim() == null) {
                                for (var i = 0; i < listaGatos.length; i++) {
                                  if (listaGatos[i].id == id) {
                                    listaGatos[i] = Gato(
                                        id,
                                        imagem,
                                        txtNome.text.trim(),
                                        txtRaca.text.trim(),
                                        int.parse(txtIdade.text.trim()),
                                        txtDono.text.trim());
                                  }
                                }
                              } else {
                                for (var i = 0; i < listaGatos.length; i++) {
                                  if (listaGatos[i].id == id) {
                                    listaGatos[i] = Gato(
                                        id,
                                        txtImagem.text.trim(),
                                        txtNome.text.trim(),
                                        txtRaca.text.trim(),
                                        int.parse(txtIdade.text.trim()),
                                        txtDono.text.trim());
                                  }
                                }
                              }
                            }
                            Navigator.pop(context);
                          },
                          child: Text("Salvar Gatito"))
                    ],
                  ),
                )),
          )),
    );
  }
}
