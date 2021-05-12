import 'package:blue_car/Services/bluecar_api.dart';
import 'package:blue_car/model/chat_room.dart';
import 'package:blue_car/model/chats_list.dart';
import 'package:blue_car/widget/chat_body_widget.dart';
import 'package:blue_car/widget/chat_header_widget.dart';

import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.blue,
    body: SafeArea(
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
                  return buildText('No Users Found');
                } else
                  return Column(
                    children: [
                      // ChatHeaderWidget(users: chatsList),
                      ChatBodyWidget(chatsList: chatsList)
                    ],
                  );
              }
          }
        },
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