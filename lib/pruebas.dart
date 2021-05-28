import 'dart:io';

import 'package:blue_car/Screens/Buscar/buscar_app_theme.dart';
import 'package:blue_car/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blue_car/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:blue_car/Services/auth_services.dart';

import 'Services/auth_services.dart';


class NewEditarPerfil extends StatefulWidget {
  @override
  _NewEditarPerfilState createState() => _NewEditarPerfilState();
}

class _NewEditarPerfilState extends State<NewEditarPerfil> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  File _image;
  final picker = ImagePicker();

  String url;

  void updateProfile(String email, String name, String password, File image) {
    if (image == null) {
      context
          .read<AuthService>()
          .updateUser(email, password, name, "").then((value) => CustomSnackBar(context, const Text('Cambios realizados correctamente!'),Colors.green));

    } else {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
      storage.ref().child("avatares/image1" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(image);
      uploadTask.whenComplete(() {
        ref.getDownloadURL().then(
              (value) {
            context
                .read<AuthService>()
                .updateUser(email, password, name, value);
            setState(() {
              url = value;
            });
          },
        );
        CustomSnackBar(context, const Text('Cambios realizados correctamente!'),Colors.green);
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final emailUser = auth.currentUser.email;
    final nameUser = auth.currentUser.displayName;
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
                    SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 115,
                                width: 115,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: new Border.all(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        backgroundImage: _image == null
                                            ? NetworkImage(
                                            auth.currentUser.photoURL == null
                                                ? _image.path
                                                : auth.currentUser.photoURL)
                                            : FileImage(_image),
                                        radius: 60,
                                      ),
                                    ),
                                    Positioned(
                                      right: -16,
                                      bottom: 0,
                                      child: SizedBox(
                                        height: 46,
                                        width: 46,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            side: BorderSide(color: Colors.white),
                                          ),
                                          color: Color(0xFFF5F6F9),
                                          onPressed: () {
                                            getImage();
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/Camera Icon.svg"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
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
                        child: Text("General", textAlign: TextAlign.left,style: TextStyle(color: Colors.white, fontSize: 17)),
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Container(
                      child: buildTextField("Full Name", nameUser, false, nameController),
                    ),

                    Container(
                      child: buildTextField("E-mail", emailUser, false, emailController),
                    ),
                    Container(
                      child: buildTextField("Password", "********", true, passwordController),

                    )
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
                      final String email = emailController.text.trim();
                      final String name = nameController.text.trim();
                      final String password = passwordController.text.trim();

                      updateProfile(email, name, password, _image);
                    },
                    child: Center(
                      child: Text(
                        'GUARDAR',
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
      bool isPasswordTextField, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: isPasswordTextField ? !showPassword : false,
      decoration: InputDecoration(

          suffixIcon: isPasswordTextField
              ? IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.blue,
            ),
          )
              : null,
          contentPadding: EdgeInsets.all(20.0),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black26,
          )),
    );
  }

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
                  'Editar Perfil',
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
