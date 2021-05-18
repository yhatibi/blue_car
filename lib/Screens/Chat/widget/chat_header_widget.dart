import 'package:blue_car/Screens/Chat/model/user.dart';
import 'package:flutter/material.dart';

class ChatHeaderWidget extends StatelessWidget {

  const ChatHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 18),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.more_vert),
                color: Colors.white,
                iconSize: 27,
                onPressed: () {}
            ),
            Text(
                'Chats',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                iconSize: 27,
                onPressed: () {}
            )
          ],
        ),
      ],
    ),
  );
}