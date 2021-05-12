import 'package:blue_car/model/chat_room.dart';
import 'package:blue_car/models/anuncio.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../data.dart';
import '../utils.dart';
import 'package:blue_car/model/message.dart';
import 'package:blue_car/model/user.dart';
import 'package:blue_car/model/chats_list.dart';
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

Stream<List<ChatsList>> getChatsList() => FirebaseFirestore.instance
    .collection('users').doc(myId).collection('chats')
    .orderBy(ChatsListField.timeLastMessage, descending: true)
    .snapshots()
    .transform(Utils.transformer(ChatsList.fromJson));

Future createChatRoom(String idUser, String message, String idAnuncio) async {
  String idChatRoom;
  int contador = 0;
  bool chatRoomWhileDone = false;

  //Problemas soulcionas con el bucle y el while: Boton CHATEAR no vuelve a crear una chatroom si no que utiliza ya las creadas anteriormente
  // while (chatRoomWhileDone != true) {
  //   print(idAnuncio);
  //   try {
  //     await FirebaseFirestore.instance
  //         .doc("users/$myId/chats/$idAnuncio")
  //         .get()
  //         .then((doc) async {
  //       if (doc.exists) {
  //         print('chat room existe');
  //         uploadMessage(myId, message, idAnuncio);
  //         chatRoomWhileDone = true;
  //       } else {
  //           await FirebaseFirestore.instance
  //               .doc("users/$idUser/chats/$idAnuncio")
  //               .get()
  //               .then((doc) async {
  //             if (doc.exists) {
  //               print('chat room existe de parte del creador del anuncio');
  //             } else {
  //               print('no existe chat room');
  //               await FirebaseFirestore.instance.collection('users').doc(idUser).collection('chats').doc(idAnuncio)
  //                   .set({
  //                     'name': idUser,
  //                     'urlPhoto': idUser,
  //                     'lastMessage': message,
  //                     'timeLastMessage': DateTime.now(),
  //                   })
  //                   .then((value) => FirebaseFirestore.instance.collection('users').doc(myId).collection('chats').doc(idAnuncio)
  //                       .set({
  //                         'name': idUser,
  //                         'urlPhoto': idUser,
  //                         'lastMessage': message,
  //                         'timeLastMessage': DateTime.now(),
  //                       }))
  //                   .then((value) => print("Added!"))
  //                   .catchError((error) => print("Failed to add : $error"))
  //                   .then((value) => uploadMessage(idUser, message, idAnuncio));
  //               chatRoomWhileDone = true;
  //             }
  //           });
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   if (chatRoomWhileDone == false) {
  //     contador++;
  //     idAnuncio += contador.toString();
  //   }
  // }


  await FirebaseFirestore.instance
      .doc("users/$myId/chats/$idAnuncio$myId")
      .get()
      .then((doc) async {
    if (doc.exists) {
      print('chat room existe, se envia solo el mensaje');
      uploadMessage(myId, message, idAnuncio);
    } else {
      print('no existe chat room');
      await FirebaseFirestore.instance.collection('users').doc(idUser).collection('chats').doc(idAnuncio+myId)
          .set({
        'name': idUser,
        'urlPhoto': idUser,
        'lastMessage': message,
        'timeLastMessage': DateTime.now(),
      })
          .then((value) => FirebaseFirestore.instance.collection('users').doc(myId).collection('chats').doc(idAnuncio+myId)
          .set({
        'name': idUser,
        'urlPhoto': idUser,
        'lastMessage': message,
        'timeLastMessage': DateTime.now(),
      }))
          .then((value) => print("Added!"))
          .catchError((error) => print("Failed to add : $error"))
          .then((value) => uploadMessage(myId, message, idAnuncio));
      chatRoomWhileDone = true;
    }
  });


  return idChatRoom;
}

Future uploadMessage(String idUser, String message, String idAnuncio) async {
  print('Upload mensaje del anuncio $idAnuncio');

  final refMessages = FirebaseFirestore.instance
      .collection('chats')
      .doc(idAnuncio+myId)
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
