import 'dart:io';
import 'dart:typed_data';

import 'package:blue_car/Screens/Buscar/buscar_app_theme.dart';
import 'package:blue_car/Screens/CrearAnuncio/model/image_upload_model.dart';
import 'package:blue_car/data.dart';
import 'package:blue_car/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

import '../../theme.dart';

class CrearAnuncioScreen extends StatefulWidget {
  @override
  _CrearAnuncioScreenState createState() => _CrearAnuncioScreenState();
}

class _CrearAnuncioScreenState extends State<CrearAnuncioScreen> {
  String combustilble = 'Diesel';
  String cambio = 'manual';
  List<Asset> images = <Asset>[];
  List<String> urlImages = <String>[];
  String _error = 'No Error Dectected';
  bool showPassword = false;


  final TextEditingController tituloController = new TextEditingController();
  final TextEditingController descController = new TextEditingController();
  final TextEditingController precioController = new TextEditingController();
  final TextEditingController anoController = new TextEditingController();
  final TextEditingController kmController = new TextEditingController();
  final TextEditingController cvController = new TextEditingController();
  final TextEditingController puertasController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          Asset asset = images[index];

          return Stack(
            children: <Widget>[
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 2,
                margin: EdgeInsets.all(5),
              ),
              Positioned(
                right: 7,
                top: 7,
                child: InkWell(
                  child: Icon(
                    Icons.delete_forever,
                    size: 22,
                    color: Colors.redAccent,
                  ),
                  onTap: () {
                    setState(() {
                      images.removeAt(index);
                    });
                  },
                ),
              ),
            ],
          );
        }
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 15,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if(resultList.length > 0) {
      setState(() {
        images = resultList;
        _error = error;
      });
    }
  }


  Future uploadToFirebase(String id) async {
    images.forEach((filePath) async {
      var path2 =
      await FlutterAbsolutePath.getAbsolutePath(filePath.identifier);
      //var path = await images[i].filePath;
      File f = await File(path2);
      await upload(f, id);
    });
  }

  upload(filePath, String id) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
    storage.ref().child("anuncios/$id/image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(filePath);
    uploadTask.whenComplete(() async {
      await ref.getDownloadURL().then( (value) {
        urlImages.add(value);
        },
      ).then((value) =>
          urlImages.forEach((element) {
            print(element);
            FirebaseFirestore.instance.collection('anuncios').doc(id)
                .update({'imagenes': FieldValue.arrayUnion([element])
            });
          })
      ).then((value) => CustomSnackBar(context, const Text('Cambios realizados correctamente!'),Colors.green));
    }).catchError((onError) {
      print(onError);
    });
  }

  Future crearAnuncio(titulo, desc, precio, ano, km, cv, puertas) async {
    DocumentReference documentReference = await FirebaseFirestore.instance.collection("anuncios").doc();
    documentReference
      .set({
      'id' : documentReference.id,
      'titulo' : titulo,
      'precio' : precio,
      'creador' : myId,
      'descripcion' : desc,
      'createdAt' : DateTime.now(),
      'favoritos' : '',
      'combustible' : combustilble,
      'ano' : ano,
      'kilometros' : km,
      'cavallos' : cv,
      'puertas' : puertas,
      }).then((value) => uploadToFirebase(documentReference.id));
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      color: BuscarAppTheme.buildLightTheme().backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Imagenes',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width > 360
                                        ? 18
                                        : 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          CustomTheme.loginGradientEnd,
                                          CustomTheme.loginGradientStart
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0)),
                                  width: 110,
                                  height: 110,
                                  child: Icon(
                                    Icons.add_to_photos,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                onTap: () {
                                  loadAssets();
                                },
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                height: 120,
                                width: 150,
                                child: buildGridView(),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Información del coche:", textAlign: TextAlign.left,style: TextStyle(color: Colors.white, fontSize: 17)),
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Container(
                      child: buildTextField("Titulo *", "Seat Ibiza...", false, tituloController),
                    ),
                    Container(
                      child: buildTextField("Descripción *", "El coche esta nuevo, solo tiene...", false, descController),
                    ),
                    Container(
                      child: buildTextField("Precio *", "10000€", true, precioController),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Información adicional:", textAlign: TextAlign.left,style: TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: buildTextField("Año", "000€", true, anoController),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: buildTextField("Kilometros", "200.000", true, kmController),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: buildTextField("CV", "120", true, cvController),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: combustilble,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                            underline: Container(
                              height: 2,
                              color: Colors.blue,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                combustilble = newValue;
                              });
                            },
                            items: <String>['Diesel', 'Gasolina']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(
                            child: buildTextField("Puertas", "4", true, puertasController),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CustomTheme.loginGradientEnd,
                      CustomTheme.loginGradientStart
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      crearAnuncio(tituloController.text, descController.text, precioController.text, anoController.text, kmController.text, cvController.text, puertasController.text).then((value) => Navigator.pop(context));
                    },
                    child: Center(
                      child: Text(
                        'Crear Anuncio',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController controller) =>
     TextField(
      controller: controller,
      keyboardType: isPasswordTextField== true ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black12,
          )),
    );


  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: BuscarAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Crear Anuncio',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
