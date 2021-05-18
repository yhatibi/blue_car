import 'package:blue_car/Screens/Chat/model/chats_list.dart';
import 'package:blue_car/Screens/Chat/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<ChatsList> chatsList;
  final String myID;

  const ChatBodyWidget({
    @required this.chatsList,
    Key key,
    this.myID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFF5F6F9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var chat = chatsList[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChatPage(idChat: chat.id, idUser: chat.otherIdUser),
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    // backgroundImage: NetworkImage(chat.urlPhoto),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: 200, maxWidth: 200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),

                        Text(chat.lastMessage,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            softWrap: false),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                      chat.timeLastMessage.hour.toString()+':'+chat.timeLastMessage.minute.toString()
                  )
                ],
              ),
            ),
          );
        },
        itemCount: chatsList.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.transparent),
      );
}
