import 'package:blue_car/Screens/Chat/widget/%20messages_widget.dart';
import 'package:blue_car/Screens/Chat/widget/new_message_widget.dart';
import 'package:blue_car/Screens/Chat/widget/profile_header_widget.dart';
import 'package:flutter/material.dart';

import '../../data.dart';
import '../../theme.dart';

class ChatPage extends StatefulWidget {
  final String idUser;
  final String idAnuncio;
  final String idChat;
  final String tituloAnuncio;

  const ChatPage({
    Key key, this.idUser, this.idAnuncio, this.idChat, this.tituloAnuncio,
  }) : super(key: key);




  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                CustomTheme.loginGradientStart,
                CustomTheme.loginGradientEnd
              ],
            )
        ),
        child: Column(
          children: [
            ProfileHeaderWidget(name: 'Hello'),
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
                child: MessagesWidget(idChatRoom: widget.idChat ?? widget.idAnuncio+myId),
              ),
            ),
            NewMessageWidget(chatRoomID: widget.idChat, idUser: widget.idUser, idAnuncio: widget.idAnuncio, tituloAnuncio: widget.tituloAnuncio)
          ],
        ),
      ),
    ),
  );
}