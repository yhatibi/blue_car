import 'package:blue_car/model/user.dart';
import 'package:blue_car/widget/%20messages_widget.dart';
import 'package:blue_car/widget/new_message_widget.dart';
import 'package:blue_car/widget/profile_header_widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String idUser;
  final String idAnuncio;

  const ChatPage({
    Key key, this.idUser, this.idAnuncio,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Colors.blue,
    body: SafeArea(
      child: Column(
        children: [
          // ProfileHeaderWidget(name: widget.user.name),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: MessagesWidget(idChatRoom: NewMessageWidget(idUser: widget.idUser, idAnuncio: widget.idAnuncio).chatRoomID),
            ),
          ),
          NewMessageWidget(idUser: widget.idUser, idAnuncio: widget.idAnuncio)
        ],
      ),
    ),
  );
}