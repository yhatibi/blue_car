import 'package:blue_car/Screens/Welcome/welcome_screen.dart';
import 'package:blue_car/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'Screens/Home/drawerScreen.dart';
import 'Screens/Home/homeScreen.dart';
void main(){
  runApp(MaterialApp(home: HomePage(),
    theme: ThemeData(
        fontFamily: 'Circular'
    ),
  ));
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          LoginPage()

        ],
      ),

    );
  }
}