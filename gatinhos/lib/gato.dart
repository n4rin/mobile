import 'package:gatinhos/gato-repository.dart';

class Gato {
  String _nome, _raca, _dono, _imagem;
  int _idade, id;

  Gato(this.id, this._imagem, this._nome, this._raca, this._idade, this._dono);

  get imagem => _imagem;
  set imagem(value) => this._imagem = value;

  get nome => _nome;
  set nome(value) => this._nome = value;

  get raca => _raca;
  set raca(value) => _raca = value;

  get idade => _idade;
  set idade(value) => _idade = value;

  get dono => _dono;
  set dono(value) => _dono = value;
}
