import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blue_car/Screens/Anuncio/anuncio_screen.dart';
import 'package:blue_car/Screens/Perfil/my_anuncios/my_anucnios.dart';
import 'package:blue_car/Services/bluecar_api.dart';
import 'package:blue_car/models/anuncio.dart';
import 'package:blue_car/models/anuncios_list.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:blue_car/Screens/Chat/chat_page.dart';
import 'package:blue_car/widgets/custom_favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configuration.dart';
import '../../../theme.dart';

class FavoritosBodyWidget extends StatelessWidget {
  final List<AnunciosList> anunciosList;

  const FavoritosBodyWidget({
    @required this.anunciosList,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.5;
    final double itemWidth = size.width / 2;

    return Expanded(
      child: Container(

          child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / 250),
        children: List.generate(anunciosList.length, (index) {
          final anuncio = anunciosList[index];
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 8.0),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/images/coche.jpg', //TODO fill path
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.all(15),
                          child: FavoriteButton(
                            isFavorite: false,
                            iconDisabledColor: Colors.blue,
                            iconSize: 30.0,
                            valueChanged: (_isFavorite) {
                              favorito(anuncio.id, _isFavorite);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      child: new Stack(
                        //alignment:new Alignment(x, y)
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  anuncio.titulo,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
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
                              margin: EdgeInsets.only(left: 10, bottom: 10),
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
                                          fontSize: 11, color: Colors.black26)),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(20.0),
                                  bottomRight: const Radius.circular(20.0),
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
                              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
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
        }),
      )),
    );
  }
}
