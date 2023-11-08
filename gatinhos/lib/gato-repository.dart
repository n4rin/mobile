import 'package:gatinhos/gato.dart';

class GatoRepository {
  static List<Gato> _gatos = [
    Gato(
        1,
        "https://scarletviolet.pokemon.com/_images/pokemon/sprigatito/pokemon-sprigatito.webp",
        "Jucelino",
        "sprigatito",
        7,
        "Vinicius"),
    Gato(2, "https://assets.pokemon.com/assets/cms2/img/pokedex/full/725.png",
        "Shitten", "Litten", 8, "Eike")
  ];
  static get getGatos => _gatos;
  static set gatos(value) => _gatos = value;

  void adicionar(Gato g) {
    _gatos.add(g);
  }

  void remover(Gato g) {
    _gatos.remove(g);
  }
}
