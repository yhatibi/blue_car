import 'package:blue_car/models/anuncio.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../data.dart';
import '../utils.dart';
import 'package:blue_car/model/message.dart';
import 'package:blue_car/model/user.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

Future<List<Anuncio>> getAnuncios() async {
  final firestoreInstance = FirebaseFirestore.instance;

  List<Anuncio> _anuncioLista = [];

  QuerySnapshot querySnapshot = await firestoreInstance
      .collection("Anuncios")
      .orderBy("createdAt", descending: true)
      .get();

  querySnapshot.docs.forEach((value) {
    Anuncio anuncio = Anuncio.fromMap(value.data());
    _anuncioLista.add(anuncio);
    print('Retorno');
    print(value.data());
  });

  return _anuncioLista;
}

Stream<List<User>> getUsers() => FirebaseFirestore.instance
    .collection('users')
    .orderBy(UserField.lastMessageTime, descending: true)
    .snapshots()
    .transform(Utils.transformer(User.fromJson));




Future uploadMessage(String idUser, String message) async {
  final refMessages =
      FirebaseFirestore.instance.collection('chats/$idUser/messages');

  final newMessage = Message(
    idUser: myId,
    urlAvatar: myUrlAvatar,
    username: myUsername,
    message: message,
    createdAt: DateTime.now(),
  );
  await refMessages.add(newMessage.toJson());

  final refUsers = FirebaseFirestore.instance.collection('users');
  await refUsers
      .doc(idUser)
      .update({UserField.lastMessageTime: DateTime.now()});
}



Stream<List<Message>> getMessages(String idUser) => FirebaseFirestore.instance
    .collection('chats/$idUser/messages')
    .orderBy(MessageField.createdAt, descending: true)
    .snapshots()
    .transform(Utils.transformer(Message.fromJson));




Future addRandomUsers(List<User> users) async {
  final refUsers = FirebaseFirestore.instance.collection('users');

  final allUsers = await refUsers.get();
  if (allUsers.size != 0) {
    return;
  } else {
    for (final user in users) {
      final userDoc = refUsers.doc();
      final newUser = user.copyWith(idUser: userDoc.id);

      await userDoc.set(newUser.toJson());
    }
  }
}
