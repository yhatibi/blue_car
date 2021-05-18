import 'package:blue_car/Screens/Chat/model/message.dart';
import 'package:blue_car/Services/bluecar_api.dart';
import 'package:flutter/material.dart';

import '../../../data.dart';
import ' message_widget.dart';

class MessagesWidget extends StatelessWidget {
  final String idChatRoom;

  const MessagesWidget({
    @required this.idChatRoom,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: getMessages(idChatRoom),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Algo fue mal, vuelve a intentarlo mas tarde :(');
              } else {
                final messages = snapshot.data;

                return messages.isEmpty
                    ? buildText('Dile hola! Este coche puede ser tuyo...')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return MessageWidget(
                            message: message,
                            isMe: message.idUser == myId,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
