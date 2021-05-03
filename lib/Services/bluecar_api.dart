import 'package:blue_car/models/anuncio.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getAnuncio(AnuncioNotifier anuncioNotifier) async {
  final firestoreInstance = FirebaseFirestore.instance;

  List<Anuncio> _anuncioLista = [];

  firestoreInstance.collection("Anuncios").orderBy("createdAt", descending: true).get().then((querySnapshot) {
    //print(querySnapshot);
    print("users: results: length: " + querySnapshot.docs.length.toString());
    querySnapshot.docs.forEach((value) {
      Anuncio anuncio = Anuncio.fromMap(value.data());
      _anuncioLista.add(anuncio);
      print('Retorno');
      print(value.data());
    });
  }).catchError((onError) {
    print("ERROR getCloudFirestoreUsers: "+onError);
  });

  anuncioNotifier.anuncioLista = _anuncioLista;
}