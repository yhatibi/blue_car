import 'package:blue_car/Screens/Anuncio/anuncio_screen.dart';
import 'package:blue_car/Services/bluecar_api.dart';
import 'package:blue_car/model/chats_list.dart';
import 'package:blue_car/model/user.dart';
import 'package:blue_car/models/anuncio.dart';
import 'package:blue_car/models/anuncios_list.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:blue_car/page/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../configuration.dart';

class MyAnunciosBodyWidget extends StatelessWidget {
  final List<AnunciosList> anunciosList;

  const MyAnunciosBodyWidget({
    @required this.anunciosList,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final anuncio = anunciosList[index];
          return GestureDetector(
            child: Container(
              height: 170,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
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
                              image: AssetImage("assets/images/coche.jpg"),
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
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    eliminarAnuncio(anuncio.id);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    color: Colors.redAccent,
                                    // color
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                    ),
                                    color: Colors.lightBlue, // color
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadowList,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20))),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
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
                                          anuncio.titulo,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          softWrap: false,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                              left: 10,
                                              right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Colors.black12),
                                          child: Text(
                                            "13.000€",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                            softWrap: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AnuncioScreen();
              }));
            },
          );
        },
        itemCount: anunciosList.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1),
      );
}
