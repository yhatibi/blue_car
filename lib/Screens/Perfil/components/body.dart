import 'package:blue_car/Screens/Perfil/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blue_car/Services/auth_services.dart';
import 'package:provider/provider.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final emailUser = auth.currentUser.email;
    final nameUser = auth.currentUser.displayName;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic("", false),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                nameUser,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(height: 3),
              Text(emailUser, style: TextStyle(color: Colors.black45))
            ],
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Mis Anuncios",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Configuración",
            icon: "assets/icons/Settings.svg",
            press: () {Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
          ),
          ProfileMenu(
            text: "Centro Ayuda",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Salir",
            icon: "assets/icons/Log out.svg",
            press: () {context.read<AuthService>().logout().then((value) => Navigator.pop(context));
            },
          ),
        ],
      ),
    );
  }
}
