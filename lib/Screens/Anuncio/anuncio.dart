import 'package:blue_car/Screens/Chat/screens/chats/chats_screen.dart';
import 'package:blue_car/Screens/Chat/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:blue_car/configuration.dart';

import '../../theme.dart';

class Anuncio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Expanded(
                child:Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/coche.jpg"),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(40.0),
                    ),
                  ),
                )
              ),

              Container(
                margin: const EdgeInsets.only(
                    left: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.50,

                      child: Text('Peugeot 208 2021 NUEVO', style:
                              TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,


                      ),
                    ),


                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,

                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(10.0),

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
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 10,
                          bottom: 10),
                        child: Text(
                          "13.000 EUR",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17 ,  color: Colors.white),
                        ),

                      ),
                    ),
                  ],
                ),
              ),


              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(
                                  left: 20,
                                  bottom: 10,
                                  top: 10
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)),
                              child:Column(
                                children: [
                                  Image.asset(categories[index]['iconPath'],
                                      height: 50, width: 50,color: Colors.grey[700]),

                                  Text(categories[index]['name'], style: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 12.0,
                                      color: Colors.black54),)
                                ],
                              ),

                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(

                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(15),
                    child: Text('PSA RETAIL VALENCIA única filial de PEUGEOT en Valencia, donde la satisfacción al cliente es la prioridad absoluta y más de 40 años de experiencia que nos avalan. 24 meses de garantía. Certificado del estado del vehículo +revisión de 100 puntos de control + Peugeot asistencia 24h + servicio de vehículo de sustitución + precio llave en mano . El precio financiado, está establecido al financiar su compra con PSA Finance, financiando un capital mínimo de 10000 € en 60 meses y entregando un vehículo valorado en 500€.', style:
                    TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        height: 1.3,
                      ),
                    ),
                ),
              )
            ],




          )),
          Container(
            margin: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  IconButton(icon: Icon(Icons.share),color: Colors.white, onPressed: () {})
                ],
              ),
            ),


          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 70,
              child: Row(
                children: [
                  Expanded(

                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [CustomTheme.loginGradientEnd, CustomTheme.loginGradientStart],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 10.0),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  body: Stack(
                                    children: [
                                      MessagesScreen()
                                    ],
                                  ),

                                );
                              },
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [CustomTheme.loginGradientEnd, CustomTheme.loginGradientStart],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "CHAT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
