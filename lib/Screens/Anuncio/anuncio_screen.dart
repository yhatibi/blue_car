import 'package:blue_car/Screens/Chat/chat_page.dart';
import 'package:blue_car/Services/bluecar_api.dart';

import 'package:blue_car/models/anuncio.dart';
import 'package:blue_car/models/anuncios_list.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:blue_car/widgets/custom_favorite_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blue_car/configuration.dart';
import 'package:provider/provider.dart';

import '../../data.dart';
import '../../theme.dart';
import 'package:blue_car/Screens/Chat/model/user.dart' as u;

class AnuncioScreen extends StatefulWidget {
  final AnunciosList anunciosList;

  const AnuncioScreen({Key key, this.anunciosList}) : super(key: key);

  @override
  _AnuncioScreenState createState() => _AnuncioScreenState();
}

class _AnuncioScreenState extends State<AnuncioScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    AnunciosModel anuncioNotifier = Provider.of<AnunciosModel>(context);

    var now = DateTime.now();

    final user = new u.User(
        idUser: widget.anunciosList.creador,
        name: myUsername,
        urlAvatar: myUrlAvatar,
        lastMessageTime: now);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.anunciosList.imagenes[0]),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(40.0),
                  ),
                ),
              )),
              Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        widget.anunciosList.titulo,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(20.0),
                          ),
                          gradient: LinearGradient(
                              colors: <Color>[
                                CustomTheme.loginGradientEnd,
                                CustomTheme.loginGradientStart
                              ],
                              begin: FractionalOffset(0.2, 0.2),
                              end: FractionalOffset(1.0, 1.0),
                              stops: <double>[0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: Text(
                          widget.anunciosList.precio + ' €',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 110,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            if (widget.anunciosList.ano.isNotEmpty)
                              Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(
                                      "",
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey[700]),
                                  Text(
                                    widget.anunciosList.ano,
                                    style: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 12.0,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.anunciosList.kilometros.isNotEmpty)
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(
                                      "",
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey[700]),
                                  Text(
                                    widget.anunciosList.kilometros+' km',
                                    style: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 12.0,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.anunciosList.cavallos.isNotEmpty)
                        Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(
                                      "",
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey[700]),
                                  Text(
                                    widget.anunciosList.cavallos+' cv',
                                    style: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 12.0,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.anunciosList.combustible.isNotEmpty)
                        Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(
                                      "",
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey[700]),
                                  Text(
                                    widget.anunciosList.combustible,
                                    style: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 12.0,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.anunciosList.puertas.isNotEmpty)
                        Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(
                                      "",
                                      height: 50,
                                      width: 50,
                                      color: Colors.grey[700]),
                                  Text(
                                    'Puertas: '+widget.anunciosList.puertas,
                                    style: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 12.0,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Descripción: ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.anunciosList.descripcion,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Row(
                  children: [
                    if (widget.anunciosList.creador != null &&
                        auth.currentUser.uid == widget.anunciosList.creador)
                      IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.white,
                          onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.share),
                        color: Colors.white,
                        onPressed: () {})
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  CustomTheme.loginGradientEnd,
                                  CustomTheme.loginGradientStart
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 10.0),
                            alignment: Alignment.center,
                            child: FavoriteButton(
                              isFavorite: widget.anunciosList.favoritos.contains(myId),
                              iconDisabledColor: Colors.white,
                              iconSize: 35.0,
                              valueChanged: (_isFavorite) {
                                favorito(widget.anunciosList.id, _isFavorite);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(
                                idUser: widget.anunciosList.creador,
                                idAnuncio: widget.anunciosList.id,
                                tituloAnuncio: widget.anunciosList.titulo,
                                urlImage: widget.anunciosList.imagenes[0]),
                          ));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  CustomTheme.loginGradientEnd,
                                  CustomTheme.loginGradientStart
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "CHAT",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
