import 'dart:io';

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
          onPressed: () {Navigator.pop(context);},
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
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Editar Perfil:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),
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
                      CircleAvatar(
                        backgroundImage: AssetImage(""),
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
                              child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                            ),
                          ),
                        )

                    ],
                  ),
                ),                    SizedBox(height: 20)
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
                    onPressed: ()  {
                      final String email = emailController.text.trim();
                      final String name = nameController.text.trim();
                      final String password = passwordController.text.trim();


                      context.read<AuthService>().updateUser(email,password,name,);
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
                          "GUARDAR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                          ),
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

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField, TextEditingController controller) {
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
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
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