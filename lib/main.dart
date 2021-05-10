import 'package:blue_car/Pruebas/home_screen.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:blue_car/pruebas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Home/drawerScreen.dart';
import 'Screens/Home/bottom_screen.dart';
import 'Screens/Home/homeScreen.dart';
import 'Screens/Login/login_page.dart';
import 'Services/auth_services.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(
        fontFamily: 'Circular'
    ),
  ));
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AnuncioNotifier(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: "APP",
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    // return Pruebas();
    if(user != null){
      return BottomBar();
    }
    return LoginPage();
  }

}