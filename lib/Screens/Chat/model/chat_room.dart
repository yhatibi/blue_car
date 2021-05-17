import 'package:flutter/material.dart';

import '../../../utils.dart';



class ChatRoom {
  final String idChatRoom;
  final String idAnuncio;
  final String idUser;
  final DateTime createdAt;

  const ChatRoom({
    @required this.idChatRoom,
    @required this.idAnuncio,
    @required this.idUser,
    @required this.createdAt,
  });

  static ChatRoom fromJson(Map<String, dynamic> json) => ChatRoom(
    idChatRoom: json['idChatRoom'],
    idAnuncio: json['idAnuncio'],
    idUser: json['idUser'],
    createdAt: Utils.toDateTime(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'idChatRoom': idChatRoom,
    'idAnuncio': idAnuncio,
    'idUser': idUser,
    'createdAt': Utils.fromDateTimeToJson(createdAt),
  };
}