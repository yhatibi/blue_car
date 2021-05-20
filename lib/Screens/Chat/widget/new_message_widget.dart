import 'package:blue_car/Services/bluecar_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;
  final String idAnuncio;
  final String chatRoomID;
  final String tituloAnuncio;

  const NewMessageWidget({
     this.idUser,
    Key key, this.idAnuncio,this.chatRoomID, this.tituloAnuncio,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    await createChatRoom(widget.idUser, message, widget.idAnuncio, widget.chatRoomID, widget.tituloAnuncio);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
    padding: EdgeInsets.all(15),
    child: Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20.0),
              filled: true,
              fillColor: Colors.grey[100],
              hintText: 'Escribe tu mensage...',
              hintStyle: TextStyle(fontSize: 17.0, color: Colors.grey),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(500.0),
                ),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
            onChanged: (value) => setState(() {
              message = value;
            }),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: message.trim().isEmpty ? null : sendMessage,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: <Color>[
                    CustomTheme.loginGradientEnd,
                    CustomTheme.loginGradientStart
                  ],
                  begin: FractionalOffset(0.2, 0.2),
                  end: FractionalOffset(1.0, 1.0),
                  stops: <double>[0.0, 1.0],
                  tileMode: TileMode.clamp),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Icon(Icons.send, color: Colors.white),
          ),
        ),
      ],
    ),
  );
  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }
}