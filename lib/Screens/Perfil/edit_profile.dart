import 'dart:io';

import 'package:blue_car/widgets/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:blue_car/Services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';
import 'components/profile_pic.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
  Widget build(BuildContext context) {
    final emailUser = auth.currentUser.email;
    final nameUser = auth.currentUser.displayName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, top: 25, right: 30),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Editar Perfil:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 15,
              ),
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
                    SizedBox(height: 20)
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", nameUser, false, nameController),
              buildTextField("E-mail", emailUser, false, emailController),
              buildTextField("Password", "********", true, passwordController),
              SizedBox(
                height: 35,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      final String email = emailController.text.trim();
                      final String name = nameController.text.trim();
                      final String password = passwordController.text.trim();

                      updateProfile(email, name, password, _image);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              CustomTheme.loginGradientEnd,
                              CustomTheme.loginGradientStart
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "GUARDAR",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
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

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1.0),
            ),
            contentPadding: EdgeInsets.only(bottom: 3, left: 7),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black26,
            )),
      ),
    );
  }
}
