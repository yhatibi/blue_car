import 'package:blue_car/Screens/CrearAnuncio/crear_anuncio_screen.dart';
import 'package:blue_car/Screens/Home/homeScreen.dart';
import 'package:blue_car/Screens/Perfil/profile_screen.dart';
import 'package:blue_car/Screens/Favoritos/favoritos_screen.dart';
import 'package:blue_car/Screens/Chat/chats_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pandabar/pandabar.dart';


class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String page = 'Inicio';
  String query;
  void setPage(String newPage) {
    setState(() {
      query = newPage;
      page = 'Online_query';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.white,
        buttonColor: Colors.grey,
        buttonSelectedColor: Colors.blue,
        fabColors: [Color(0xFF0bbafb), Color(0xFF4285ec)],
        buttonData: [
          PandaBarButtonData(
            id: 'Inicio',
            icon: Icons.home_filled,
            title: 'Inicio',
          ),
          PandaBarButtonData(
            id: 'Favoritos',
            icon: Icons.favorite,
            title: 'Favoritos',
          ),
          PandaBarButtonData(
              id: 'Chats',
              icon: Icons.message,
              title: 'Chats'
          ),
          PandaBarButtonData(
              id: 'Perfil',
              icon: Icons.person,
              title: 'Perfil'
          ),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return CrearAnuncioScreen();
              }));
        },
      ),

      body: Builder(
        builder: (context) {
          switch (page) {
            case 'Inicio':
              return HomeScreen();
            case 'Favoritos':
              return FavoritosScreen();
            case 'Chats':
              return ChatsPage();
            case 'Perfil':
              return ProfileScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}