import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blue_car/Screens/Anuncio/anuncio_screen.dart';
import 'package:blue_car/Screens/Perfil/my_anuncios/my_anucnios.dart';
import 'package:blue_car/Services/bluecar_api.dart';
import 'package:blue_car/data.dart';
import 'package:blue_car/models/anuncio.dart';
import 'package:blue_car/models/anuncios_list.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:blue_car/Screens/Chat/chat_page.dart';
import 'package:blue_car/widgets/custom_favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configuration.dart';
import '../../../theme.dart';


class HomeScreenBodyWidget extends StatelessWidget {
  final List<AnunciosList> anunciosList;

  const HomeScreenBodyWidget({
    @required this.anunciosList,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      child: buildChats(),
    ),
  );

  Widget buildChats() => ListView.separated(
    physics: BouncingScrollPhysics(),
    padding: EdgeInsets.zero,
    itemBuilder: (context, index) {
      final anuncio = anunciosList[index];
      return  GestureDetector(
        child: Container(

          height: 170,
          margin:
          const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/images/coche.jpg"),
                        ),
                        boxShadow: shadowList,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: FavoriteButton(
                            isFavorite: anuncio.favoritos.contains(myId),
                            iconDisabledColor: Colors.blue,
                            iconSize: 35.0,
                            valueChanged: (_isFavorite) {
                              favorito(anuncio.id, _isFavorite);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: shadowList,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    height: double.maxFinite,
                    child: new Stack(
                      //alignment:new Alignment(x, y)
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                anuncio.titulo,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                fontSize: 16),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: false,
                              ),
                              SizedBox(height: 5),
                              Text(
                                anuncio.descripcion,
                                style: const TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54),
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                                softWrap: false,
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 25,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "250.000km",
                                        style: const TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.black54),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "2019",
                                        style: const TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.black54),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "2019",
                                        style: const TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.black54),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 10, bottom: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.black26,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text("10h",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black26)),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft:
                                const Radius.circular(20.0),
                                bottomRight:
                                const Radius.circular(20.0),
                              ),
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    CustomTheme
                                        .loginGradientEnd,
                                    CustomTheme
                                        .loginGradientStart
                                  ],
                                  begin: FractionalOffset(
                                      0.2, 0.2),
                                  end: FractionalOffset(
                                      1.0, 1.0),
                                  stops: <double>[0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "13.000 EUR",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return AnuncioScreen(anunciosList: anuncio);
          }));
        },
      );
    },
    itemCount: anunciosList.length,
    separatorBuilder: (BuildContext context, int index) =>
        Divider(height: 1, color: Colors.transparent,),
  );
}

Widget confirmDelete(String idAnuncio) {}
