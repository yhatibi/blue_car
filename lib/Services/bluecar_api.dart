import 'package:blue_car/Screens/Chat/model/chats_list.dart';
import 'package:blue_car/Screens/Chat/model/message.dart';
import 'package:blue_car/Screens/Chat/model/user.dart';
import 'package:blue_car/models/anuncio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data.dart';
import '../utils.dart';
import 'package:blue_car/models/anuncios_list.dart';

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



Future<void> eliminarAnuncio(String idAnuncio) {
  FirebaseFirestore.instance.collection('Anuncios')
      .doc(idAnuncio)
      .delete()
      .then((value) => print("Anuncio eliminado correctamente!"))
      .catchError((error) => print("Error al eliminar anuncio: $error"));
}


Stream<List<ChatsList>> getChatsList() => FirebaseFirestore.instance
    .collection('users').doc(myId).collection('chats')
    .orderBy(ChatsListField.timeLastMessage, descending: true)
    .snapshots()
    .transform(Utils.transformerFromDoc(ChatsList.fromDoc));

Stream<List<AnunciosList>> getAnunciosList() => FirebaseFirestore.instance
    .collection('Anuncios')
    .orderBy(AnunciosListField.createdAt, descending: true)
    .snapshots()
    .transform(Utils.transformer(AnunciosList.fromJson));


Stream<List<AnunciosList>> getConcretAnunciosList(String idUser) => FirebaseFirestore.instance
    .collection('Anuncios')
    .where('creador', isEqualTo: idUser)
    .orderBy(AnunciosListField.createdAt, descending: true)
    .snapshots()
    .transform(Utils.transformer(AnunciosList.fromJson));

Future createChatRoom(String idUser, String message, String idAnuncio, String idChatRoom, String tituloAnuncio) async {
  int contador = 0;
  bool chatRoomWhileDone = false;
  print('Chat Room id: $idChatRoom');

  await FirebaseFirestore.instance
      .doc("users/$myId/chats/$idChatRoom")
      .get()
      .then((doc) async {
    if (doc.exists) {
      print('chat room existe, se envia solo el mensaje (idChatRoom: $idChatRoom, MyId: $myId, UserID: $idUser)');
      uploadMessage(myId, message, idChatRoom).then((value) async =>
      await FirebaseFirestore.instance.collection('users').doc(idUser).collection('chats').doc(idChatRoom)
          .update({
        'lastMessage': message,
        'timeLastMessage': DateTime.now(),
      })
          .then((value) => FirebaseFirestore.instance.collection('users').doc(myId).collection('chats').doc(idChatRoom)
          .update({
        'lastMessage': message,
        'timeLastMessage': DateTime.now(),
      })));

    } else {
      print('no existe chat room');
      await FirebaseFirestore.instance.collection('users').doc(idUser).collection('chats').doc(idAnuncio+myId)
          .set({
        'idAnuncio': idAnuncio,
        'otherIdUser': myId,
        'name': tituloAnuncio,
        'urlPhoto': idUser,
        'lastMessage': message,
        'timeLastMessage': DateTime.now(),
      })
          .then((value) => FirebaseFirestore.instance.collection('users').doc(myId).collection('chats').doc(idAnuncio+myId)
          .set({
        'idAnuncio': idAnuncio,
        'otherIdUser': idUser,
        'name': tituloAnuncio,
        'urlPhoto': idUser,
        'lastMessage': message,
        'timeLastMessage': DateTime.now(),
      }))
          .then((value) => print("Added!"))
          .catchError((error) => print("Failed to add : $error"))
          .then((value) => uploadMessage(myId, message, idAnuncio+myId));
      chatRoomWhileDone = true;
    }
  });


  return idChatRoom;
}

Future uploadMessage(String idUser, String message, String idChatRoom) async {
  print('Upload mensaje del anuncio $idChatRoom');

  final refMessages = FirebaseFirestore.instance
      .collection('chats')
      .doc(idChatRoom)
      .collection('messages');

  final newMessage = Message(
    idUser: myId,
    urlAvatar: myUrlAvatar,
    username: myUsername,
    message: message,
    createdAt: DateTime.now(),
  );
  await refMessages.add(newMessage.toJson());
}

Stream<List<Message>> getMessages(String idChatRoom) =>
    FirebaseFirestore.instance
        .collection('chats/$idChatRoom/messages')
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

Future isFavorito (String idAnuncio) async {
  int numeroDocs = await FirebaseFirestore.instance.collection('Anuncios').where('favoritos', arrayContainsAny: [myId]).snapshots().length;

  if (numeroDocs < 0){
    return true;
  } else return false;
}

Future favorito (String idAnuncio, bool taped) async {
  if (taped == true) {
    await FirebaseFirestore.instance.collection('Anuncios').doc(idAnuncio)
        .update({'favoritos': FieldValue.arrayUnion([myId])
    });
  } else {
    await FirebaseFirestore.instance.collection('Anuncios').doc(idAnuncio)
        .update({'favoritos': FieldValue.arrayRemove([myId])
    });
  }
}


Stream<List<AnunciosList>> getFavoritosAnunciosList() => FirebaseFirestore.instance
    .collection('Anuncios')
    .where('favoritos', arrayContainsAny: [myId])
    .orderBy(AnunciosListField.createdAt, descending: true)
    .snapshots()
    .transform(Utils.transformer(AnunciosList.fromJson));
