import 'package:flutter/material.dart';
import 'package:gatinhos/edita.dart';
import 'package:gatinhos/form.dart';
import 'package:gatinhos/gato-repository.dart';
import 'package:gatinhos/gato.dart';

class ListaGatos extends StatefulWidget {
  const ListaGatos({super.key});

  @override
  State<ListaGatos> createState() => _ListaGatosState();
}

class _ListaGatosState extends State<ListaGatos> {
  List<Gato> listaGatos = GatoRepository.getGatos;
  String pesquisa = "";
  Gato gatoSelecionado = GatoRepository.getGatos[0];
  int indexSelecionado = 0;

  List<Gato> buscaGatos = [];

  @override
  void initState() {
    buscaGatos = List.from(listaGatos);
    if (listaGatos.length == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FormGatito()));
      setState(() {});
    }
    super.initState();
  }

  void pesquisar(String nome) {
    buscaGatos = List.from(listaGatos);
    setState(() {
      buscaGatos = listaGatos
          .where((element) =>
              (element.nome.toLowerCase().contains(nome.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (listaGatos.length == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FormGatito()));
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.search),
            Expanded(
                child: TextField(
              decoration: InputDecoration(label: Text("Pesquisa")),
              onChanged: (value) {
                pesquisa = value;
                pesquisar(pesquisa);
              },
            ))
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          color: Color.fromARGB(255, 92, 89, 177),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: [
              Container(
                height: 170,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 5),
                        borderRadius: BorderRadius.circular(50)),
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              gatoSelecionado.imagem,
                              width: 170,
                              height: 170,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      gatoSelecionado.nome,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return EditaGatito(gatoSelecionado);
                                        }));
                                        setState(() {
                                          gatoSelecionado = listaGatos[0];
                                          pesquisar(pesquisa);
                                        });
                                      },
                                      icon: Icon(Icons.edit))
                                ],
                              ),
                              Text(
                                  "Idade: " + gatoSelecionado.idade.toString()),
                              Text("Raça: " + gatoSelecionado.raca),
                              Text("Dono: " + gatoSelecionado.dono),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        for (var i = 0;
                                            i < listaGatos.length;
                                            i++) {
                                          if (listaGatos[i].id ==
                                              gatoSelecionado.id) {
                                            listaGatos.remove(gatoSelecionado);
                                          }
                                        }
                                        setState(() {
                                          gatoSelecionado = listaGatos[0];
                                          pesquisar(pesquisa);
                                        });
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(height: 10),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 5),
                          borderRadius: BorderRadius.circular(50)),
                      child: ListView.separated(
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              title: Text(buscaGatos[index].nome),
                              subtitle: Text(buscaGatos[index].dono),
                              leading: CircleAvatar(
                                child: Image.network(buscaGatos[index].imagem),
                              ),
                              trailing: SizedBox(
                                width: 70,
                                child: Row(children: [
                                  Expanded(
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              gatoSelecionado =
                                                  buscaGatos[index];
                                              indexSelecionado = index;
                                              print(gatoSelecionado.nome);
                                            });
                                          },
                                          icon: Icon(Icons.upload))),
                                ]),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(thickness: 4),
                          itemCount: buscaGatos.length)))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormGatito()));
          gatoSelecionado = listaGatos[0];
          pesquisar(pesquisa);
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
