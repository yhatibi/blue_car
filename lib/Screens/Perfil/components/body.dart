import 'package:blue_car/Screens/CentroAyuda/centro_de_ayuda.dart';
import 'package:blue_car/Screens/Login/login_page.dart';
import 'package:blue_car/Screens/Perfil/edit_profile/edit_profile.dart';
import 'package:blue_car/Screens/Perfil/my_anuncios/my_anucnios.dart';
import 'package:blue_car/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blue_car/Services/auth_services.dart';
import 'package:provider/provider.dart';

import '../../../theme.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 2),
              margin: EdgeInsets.only(bottom: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    CustomTheme.loginGradientStart,
                    CustomTheme.loginGradientEnd
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(120.0)
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(1.0, 4.0),
                    blurRadius: 20.0,
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: 40),
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120.0)
                    ),

                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(auth.currentUser.photoURL),
                        radius: 60,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          myUsername,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(height: 3),
                        Text(myEmail, style: TextStyle(color: Colors.black45))
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            ProfileMenu(
              text: "Mis Anuncios",
              icon: "assets/icons/User Icon.svg",
              press: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAnuncios()))
              },
            ),
            ProfileMenu(
              text: "Configuración",
              icon: "assets/icons/Settings.svg",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
            ),
            ProfileMenu(
              text: "Centro Ayuda",
              icon: "assets/icons/Question mark.svg",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CentroAyuda()));
              },
            ),
            ProfileMenu(
              text: "Salir",
              icon: "assets/icons/Log out.svg",
              press: () {
                context
                    .read<AuthService>()
                    .logout()
                    .then((value) {
                      return LoginPage();
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
