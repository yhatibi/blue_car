import 'package:blue_car/page/chats_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blue_car/configuration.dart';
import 'package:provider/provider.dart';
import 'package:blue_car/Services/auth_services.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();

}



class _DrawerScreenState extends State<DrawerScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailUser = auth.currentUser.email;
    final nameUser = auth.currentUser.displayName;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          lightBlueGrad,
          darkBlueGrad,
        ],
      )),
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameUser,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(emailUser, style: TextStyle(color: Colors.white))
                ],
              )
            ],
          ),
          Column(
            children: drawerItems
                .map((element) => Padding(
                      padding: const EdgeInsets.all(9.0),

                      child: Row(
                        children: [
                          Icon(
                            element['icon'],
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(element['title'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18))
                        ],
                      ),
                    ))
                .toList(),
          ),
          Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatsPage()));
              },
              child: const Text(
                          'Settings',
                          style:
                              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.logout,
                color: Colors.white,
              ),
              SizedBox(
                width: 4,
              ),
              TextButton(
                  onPressed: () {
                    context.read<AuthService>().logout();
                  },
                  child: const Text(
                    'Log out',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
