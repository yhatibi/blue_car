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
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../configuration.dart';
import '../../data.dart';
import '../../theme.dart';



class BuscarListView extends StatelessWidget {
  final List<AnunciosList> anunciosList;


  const BuscarListView({
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
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
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
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: anuncio.imagenes == null ? AssetImage("assets/images/no-image.png") : NetworkImage(anuncio.imagenes[0]),
                                    ),
                                    boxShadow: shadowList,
                                    borderRadius: BorderRadius.circular(15),
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
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                            softWrap: false,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            height: 25,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                if (anuncio.ano.isNotEmpty)
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black12,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Text(
                                                      anuncio.ano,
                                                      style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black54),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                SizedBox(width: 5),
                                                if (anuncio.kilometros.isNotEmpty)
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black12,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Text(
                                                      anuncio.kilometros+' km',
                                                      style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black54),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                SizedBox(width: 5),
                                                if (anuncio.cavallos.isNotEmpty)
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black12,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Text(
                                                      anuncio.cavallos+' cv',
                                                      style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black54),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                SizedBox(width: 5),
                                                if (anuncio.combustible.isNotEmpty)
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black12,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Text(
                                                      anuncio.combustible,
                                                      style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black54),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                SizedBox(width: 5),
                                                if (anuncio.puertas.isNotEmpty)
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black12,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Text(
                                                      'Puertas: '+anuncio.puertas,
                                                      style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black54),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                SizedBox(width: 5),
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
                                            Text(
                                                DateTime.now().difference(anuncio.createdAt).inHours < 24
                                                    ? DateTime.now().difference(anuncio.createdAt).inMinutes < 60
                                                    ? DateTime.now().difference(anuncio.createdAt).inMinutes.toString() + 'min'
                                                    :  DateTime.now().difference(anuncio.createdAt).inHours.toString() + 'h'
                                                    : DateTime.now().difference(anuncio.createdAt).inDays.toString()+'dias',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.black26)
                                            ),
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
                                          anuncio.precio+'€',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15
                                          ),
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
                    ),
                  ),
                ),
              );
            }),
          )),
    );
  }
}