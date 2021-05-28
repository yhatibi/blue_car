import 'package:blue_car/Services/bluecar_api.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blue_car/Screens/Favoritos/widget/favoritos_body_widget.dart';
import 'package:blue_car/models/anuncios_list.dart';

import 'package:blue_car/theme.dart';
import 'package:blue_car/widgets/gradient_icon.dart';
import 'package:provider/provider.dart';

import '../../configuration.dart';

class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

class _FavoritosScreenState extends State<FavoritosScreen> {
  @override
  void initState() {
    AnunciosModel anunciosModel =
    Provider.of<AnunciosModel>(context, listen: false);

    _getAnuncios(anunciosModel);
    super.initState();
  }

  _getAnuncios(AnunciosModel anunciosModel) async {
    anunciosModel.anuncioLista = await getAnuncios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],

        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomRight: const Radius.circular(30.0),
                      bottomLeft: const Radius.circular(30.0),
                    ),
                    color: Colors.white,

                  ),
                  width: MediaQuery.of(context).size.width * 1,
                  height: 70,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 20),

                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      GradientIcon(
                        Icons.favorite,
                        25.0,
                        LinearGradient(
                          colors: <Color>[
                            CustomTheme.loginGradientEnd,
                            CustomTheme.loginGradientStart
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Favoritos",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 25),
                      ),
                    ],
                  )
              ),
              Container(

                child: Expanded(
                  child: StreamBuilder<List<AnunciosList>>(
                    stream: getFavoritosAnunciosList(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError) {
                            print(snapshot.error);
                            return buildText('Algo fue mal, vuelve a intentarlo mas tarde :(');
                          } else {
                            final anunciosList = snapshot.data;
                            if (anunciosList.isEmpty) {
                              return buildText('No Anuncios encontrados');
                            } else
                              print('ANUNCIOS:');
                            return Column(
                              children: [
                                FavoritosBodyWidget(anunciosList: anunciosList),
                              ],
                            );
                          }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildText(String text) => Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.black87),
      ),
    ),
  );
}
