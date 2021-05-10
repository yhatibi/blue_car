import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blue_car/Services/auth_services.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'Services/bluecar_api.dart';
import 'notifier/anuncio_notifier.dart';


class Pruebas extends StatefulWidget {
  @override
  _PruebasState createState() => _PruebasState();
}

class _PruebasState extends State<Pruebas> {
  void initState() {
    AnunciosModel anuncioNotifier = Provider.of<AnunciosModel>(context, listen: false);
    // getAnuncio(anuncioNotifier);
    super.initState();
  }
  // String nombre = "waiting";
  // final FirebaseAuth auth = FirebaseAuth.instance;
  //
  // void creaperfil() async {
  //   await context.read<AuthService>().signUp("lddsdca@dfsdlslq.com","123456papa","Juan mario",);
  //   await context.read<AuthService>().updateUser("","","ASD sdad SDA",);
  //
  //   setState(() {
  //     print("********");
  //     print(auth.currentUser);
  //     // nombre = auth.currentUser.displayName;
  //   });
  //
  // }
  // @override
  // void initState() {
  //   super.initState();
  //
  //   creaperfil();
  //
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       child: Text(nombre),
  //     ),
  //   );
  // }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AnunciosModel anuncioNotifier = Provider.of<AnunciosModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text(anuncioNotifier.anuncioLista[index].titulo),
            subtitle: Text(anuncioNotifier.anuncioLista[index].descripcion),
          );
        },
        itemCount: anuncioNotifier.anuncioLista.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black38,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );

  }
}
