import 'package:blue_car/Screens/Anuncio/anuncio_screen.dart';
import 'package:blue_car/Screens/Anuncio/create_edit_anuncio_screen.dart';
import 'package:blue_car/Screens/Perfil/components/profile_pic.dart';
import 'package:blue_car/Screens/Perfil/profile_screen.dart';
import 'package:blue_car/Services/bluecar_api.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:blue_car/widgets/custom_favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blue_car/configuration.dart';
import 'package:blue_car/theme.dart';
import 'package:blue_car/widgets/snackbar.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
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
  final _advancedDrawerController = AdvancedDrawerController();

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

  String page = 'Blue';

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
          body: AnimatedContainer(
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
                margin: const EdgeInsets.only(
                    bottom: 30.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: IconButton(
                          onPressed: _handleMenuButtonPressed,
                          icon: ValueListenableBuilder<AdvancedDrawerValue>(
                            valueListenable: _advancedDrawerController,
                            builder: (context, value, child) {
                              return Icon(
                                value.visible ? Icons.clear : Icons.menu,
                              );
                            },
                          ),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                height: 100,
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
              Container(
                height: 30,
                margin: EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Ultimos anuncios:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ),
              ),
              Consumer<AnunciosModel>(
                builder: (context, anunciosModel, child) => ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  // <-- this will disable scroll
                  shrinkWrap: true,
                  itemCount: anunciosModel.anuncioLista.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        height: 170,
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                                          isFavorite: false,
                                          iconDisabledColor: Colors.white,
                                          iconSize: 35.0,
                                          valueChanged: (_isFavorite) {
                                            print('Is Favorite : $_isFavorite');
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
                                              anunciosModel
                                                  .anuncioLista[index].titulo,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.clip,
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              anunciosModel.anuncioLista[index]
                                                  .descripcion,
                                              style: const TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black54),
                                              overflow: TextOverflow.fade,
                                              maxLines: 2,
                                              softWrap: false,
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(height: 5),
                                            Wrap(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    boxShadow: shadowList,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                    boxShadow: shadowList,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                                  CustomTheme.loginGradientEnd,
                                                  CustomTheme.loginGradientStart
                                                ],
                                                begin:
                                                    FractionalOffset(0.2, 0.2),
                                                end: FractionalOffset(1.0, 1.0),
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
                        anunciosModel.actualAnuncio =
                            anunciosModel.anuncioLista[index];
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return AnuncioScreen();
                        }));
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.transparent,
                    );
                  },
                ),
              ),
              Text("No hay Anuncios!"),
            ],
          ),
        ),
      )),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/flutter_logo.png',
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.favorite),
                  title: Text('Favourites'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
