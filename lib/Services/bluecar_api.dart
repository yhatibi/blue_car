import 'package:blue_car/models/anuncio.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';



Future<List<Anuncio>> getAnuncios() async {
  final firestoreInstance = FirebaseFirestore.instance;

  List<Anuncio> _anuncioLista = [];

  QuerySnapshot querySnapshot = await firestoreInstance.collection("Anuncios").orderBy("createdAt", descending: true).get();


  querySnapshot.docs.forEach((value) {
    Anuncio anuncio = Anuncio.fromMap(value.data());
    _anuncioLista.add(anuncio);
    print('Retorno');
    print(value.data());
  });

  return _anuncioLista;
}

