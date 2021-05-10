import 'package:blue_car/Screens/Anuncio/anuncio_screen.dart';
import 'package:blue_car/Screens/Anuncio/create_edit_anuncio_screen.dart';
import 'package:blue_car/Screens/Chat/screens/chats/chats_screen.dart';
import 'package:blue_car/Screens/Perfil/components/profile_pic.dart';
import 'package:blue_car/Screens/Perfil/profile_screen.dart';
import 'package:blue_car/Services/bluecar_api.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blue_car/configuration.dart';
import 'package:blue_car/theme.dart';
import 'package:blue_car/widgets/snackbar.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';
import 'package:provider/provider.dart';
import 'package:blue_car/Services/auth_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AnuncioNotifier anuncioNotifier =
        Provider.of<AnuncioNotifier>(context, listen: false);
    getAnuncio(anuncioNotifier);
    super.initState();
  }

  int _currentIndex = 0;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    AnuncioNotifier anuncioNotifier = Provider.of<AnuncioNotifier>(context);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.white,
        buttonColor: Colors.grey,
        buttonSelectedColor: Colors.blue,
        fabColors: [Colors.red.shade900, Colors.red],
        buttonData: [
          PandaBarButtonData(
            id: 'Blue',
            icon: Icons.home_filled,
            title: 'Inicio',
          ),
          PandaBarButtonData(
              id: 'Green',
              icon: Icons.favorite,
              title: 'Favoritos'
          ),
          PandaBarButtonData(
              id: 'Red',
              icon: Icons.message,
              title: 'Chats'
          ),
          PandaBarButtonData(
              id: 'Yellow',
              icon: Icons.person,
              title: 'Perfil'
          ),
        ],
        onChange: (id) {
          setState(() {
          });
        },
        onFabButtonPressed: () {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  content: Text('Fab Button Pressed!'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Close'),
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              }
          );
        },
      ),

        body:  AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor)
            ..rotateY(isDrawerOpen ? -0.5 : 0),
          duration: Duration(milliseconds: 250),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin:
                  const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: isDrawerOpen
                            ? IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                            : IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                xOffset = 230;
                                yOffset = 150;
                                scaleFactor = 0.6;
                                isDrawerOpen = true;
                              });
                            }),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.search),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Busca tu coche...',
                              style: TextStyle(color: Colors.black54),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.10,
                          child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(auth.currentUser.photoURL)),
                        ),
                        // Handle your callback
                      )
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              width: 85,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Image.asset(categories[index]['iconPath'],
                                      height: 50, width: 50),
                                  Text(
                                    categories[index]['name'],
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
                      );
                    },
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        height: 180,
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                        AssetImage("assets/images/coche.jpg"),
                                      ),
                                      boxShadow: shadowList,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: shadowList,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  child: Column(
                                    children: [
                                      Text(
                                        anuncioNotifier.anuncioLista[index].titulo,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            anuncioNotifier.anuncioLista[index].descripcion,
                                            style: const TextStyle(
                                                fontFamily: 'WorkSansSemiBold',
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                          Text('Ukraine'),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: const Radius.circular(10.0),
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
                                              margin: EdgeInsets.all(5.0),
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
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      onTap: () {
                        anuncioNotifier.actualAnuncio = anuncioNotifier.anuncioLista[index];
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                          return AnuncioScreen();
                        }));
                      },
                    );
                  },
                  itemCount: anuncioNotifier.anuncioLista.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.transparent,
                    );
                  },
                ),

                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused))
                            return Colors.red;
                          return null; // Defer to the widget's default.
                        }
                    ),
                  ),
                  onPressed: () {
                    anuncioNotifier.actualAnuncio = null;
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return AnuncioForm(
                          isUpdating: false,
                        );
                      }),
                    );
                  },
                  child: Text('TextButton'),
                ),
                SizedBox(
                  height: 600,
                ),
              ],
            ),
          ),
        )
    );


  }
}
