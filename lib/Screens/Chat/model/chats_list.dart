import 'package:meta/meta.dart';

import '../../../utils.dart';


class ChatsListField {
  static final String timeLastMessage = 'timeLastMessage';
}

class ChatsList {
  final String name;
  final String idAnuncio;
  final String lastMessage;
  final String urlPhoto;
  final DateTime timeLastMessage;

  const ChatsList({
    @required this.name,
    @required this.idAnuncio,
    @required this.lastMessage,
    @required this.urlPhoto,
    @required this.timeLastMessage,
  });

  ChatsList copyWith({
    String lastMessage,
    String name,
    String idAnuncio,
    String urlPhoto,
    String timeLastMessage,
  }) =>
      ChatsList(
        lastMessage: lastMessage ?? this.lastMessage,
        name: name ?? this.name,
        idAnuncio: idAnuncio ?? this.idAnuncio,
        urlPhoto: urlPhoto ?? this.urlPhoto,
        timeLastMessage: timeLastMessage ?? this.timeLastMessage,
      );

  static ChatsList fromJson(Map<String, dynamic> json) => ChatsList(
    lastMessage: json['lastMessage'],
    name: json['name'],
    idAnuncio: json['idAnuncio'],
    urlPhoto: json['urlPhoto'],
    timeLastMessage: Utils.toDateTime(json['timeLastMessage']),
  );

  Map<String, dynamic> toJson() => {
    'lastMessage': lastMessage,
    'name': name,
    'idAnuncio': idAnuncio,
    'urlPhoto': urlPhoto,
    'timeLastMessage': Utils.fromDateTimeToJson(timeLastMessage),
  };
}