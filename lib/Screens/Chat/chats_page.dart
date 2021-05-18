import 'package:blue_car/Screens/Chat/widget/chat_body_widget.dart';
import 'package:blue_car/Screens/Chat/widget/chat_header_widget.dart';
import 'package:blue_car/Services/bluecar_api.dart';
import 'package:blue_car/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



import 'package:flutter/material.dart';

import '../../theme.dart';
import 'model/chats_list.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
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
      child: SafeArea(
        bottom: false,
        child: StreamBuilder<List<ChatsList>>(
          stream: getChatsList(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return buildText('Something Went Wrong Try later');
                } else {
                  final chatsList = snapshot.data;

                  if (chatsList.isEmpty) {
                    return buildText('No tienes chats!');
                  } else
                    return Column(
                      children: [
                        ChatHeaderWidget(),
                        ChatBodyWidget(chatsList: chatsList, myID: myId),
                      ],
                    );
                }
            }
          },
        ),
      ),
    ),
  );

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
}