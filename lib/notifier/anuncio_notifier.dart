import 'dart:collection';

import 'package:blue_car/models/anuncio.dart';
import 'package:flutter/cupertino.dart';

class AnuncioNotifier with ChangeNotifier{
  List<Anuncio> _anuncioLista = [];
  Anuncio _actualAnuncio;

  UnmodifiableListView<Anuncio> get anuncioLista => UnmodifiableListView(_anuncioLista);

  Anuncio get actualAnuncio => _actualAnuncio;

  set anuncioLista(List<Anuncio> anuncioLista) {
    _anuncioLista = anuncioLista;
    notifyListeners();
  }

  set actualAnuncio(Anuncio anuncio) {
    _actualAnuncio = actualAnuncio;
    notifyListeners();
  }
}