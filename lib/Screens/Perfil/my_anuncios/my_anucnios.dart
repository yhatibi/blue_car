import 'package:blue_car/Screens/Anuncio/anuncio_screen.dart';
import 'package:blue_car/Screens/Perfil/my_anuncios/widgets/my_anuncios_widtget.dart';
import 'package:blue_car/Screens/Anuncio/create_edit_anuncio_screen.dart';
import 'package:blue_car/Screens/Perfil/components/profile_pic.dart';
import 'package:blue_car/Screens/Perfil/profile_screen.dart';
import 'package:blue_car/Services/bluecar_api.dart';
import 'package:blue_car/data.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blue_car/configuration.dart';
import 'package:blue_car/models/anuncios_list.dart';

import 'package:blue_car/theme.dart';
import 'package:blue_car/widgets/snackbar.dart';
import 'package:blue_car/widgets/gradient_icon.dart';
import 'package:pandabar/model.dart';
import 'package:provider/provider.dart';
import 'package:blue_car/Services/auth_services.dart';

class MyAnuncios extends StatefulWidget {
  @override
  _MyAnunciosState createState() => _MyAnunciosState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

class _MyAnunciosState extends State<MyAnuncios> {
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
      body: SafeArea(
        child: StreamBuilder<List<AnunciosList>>(
          stream: getConcretAnunciosList(myId),
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
                      Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: EdgeInsets.only(
                            bottom: 15,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black54,
                                offset: Offset(1.0, 4.0),
                                blurRadius: 30.0,
                              ),
                            ],
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
                          child: Container(
                              width:
                              MediaQuery.of(context).size.width * 1,
                              padding:
                              EdgeInsets.only(bottom: 20, top: 20),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40.0),
                                    bottomRight: Radius.circular(40.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(1.0, 4.0),
                                      blurRadius: 30.0,
                                    ),
                                  ],
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  GradientIcon(
                                    Icons.my_library_books_rounded,
                                    30.0,
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
                                    "Mis Anuncios",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 20),
                                  ),
                                ],
                              ))),
                      MyAnunciosBodyWidget(anunciosList: anunciosList),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }



  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
      );
}
