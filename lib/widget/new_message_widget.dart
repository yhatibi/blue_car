import 'package:blue_car/Services/bluecar_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;
  final String idAnuncio;

  const NewMessageWidget({
    @required this.idUser,
    Key key, String this.idAnuncio,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();

    await uploadMessage(widget.idUser, message, widget.idAnuncio);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    padding: EdgeInsets.all(8),
    child: Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              labelText: 'Type your message',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0),
                gapPadding: 10,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onChanged: (value) => setState(() {
              message = value;
            }),
          ),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: message.trim().isEmpty ? null : sendMessage,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Icon(Icons.send, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}