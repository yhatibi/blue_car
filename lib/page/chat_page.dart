import 'package:blue_car/model/user.dart';
import 'package:blue_car/widget/%20messages_widget.dart';
import 'package:blue_car/widget/new_message_widget.dart';
import 'package:blue_car/widget/profile_header_widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final User user;
  final String idAnuncio;

  const ChatPage({
    @required this.user,
    Key key, this.idAnuncio,
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
          ProfileHeaderWidget(name: widget.user.name),
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
              child: MessagesWidget(idUser: widget.user.idUser, idAnuncio: widget.idAnuncio),
            ),
          ),
          NewMessageWidget(idUser: widget.user.idUser, idAnuncio: widget.idAnuncio)
        ],
      ),
    ),
  );
}