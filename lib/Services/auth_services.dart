import 'package:blue_car/models/anuncio.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data.dart';


class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User> get authStateChanges => _auth.idTokenChanges();

  Future<String> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> login(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password). then((value) =>myId = _auth.currentUser.uid).then((value) => myEmail = auth.currentUser.email).then((value) => myUsername = auth.currentUser.displayName).then((value) => myUrlAvatar = auth.currentUser.photoURL);
      return "Logged In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }


  Future<String> signUp(String email, String password, String name) async {
    try{

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user.updateProfile(displayName: name, photoURL: "https://firebasestorage.googleapis.com/v0/b/bluecar-eadb6.appspot.com/o/avatares%2Fa70e1675c7bc001f1578aa76bb0a7819.png?alt=media&token=21f7025d-ab0a-45fc-9ef9-ebce5004acc8");
      
      print("Registrado Correctamente");

      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }


  Future updateUser(String newEmail, String newPassword, String newName, String urlImage) async {
    try{

      if(newEmail.isNotEmpty){
        await _auth.currentUser.updateEmail(newEmail).then((value) => myEmail = newEmail);
      }
      if(newPassword.isNotEmpty) {
        await _auth.currentUser.updatePassword(newPassword);
      }
      if(newName.isNotEmpty) {
        await _auth.currentUser.updateProfile(displayName: newName).then((value) => myUsername = newName);
      }
      if(urlImage.isNotEmpty) {
        await _auth.currentUser.updateProfile(photoURL: urlImage).then((value) => myUrlAvatar = urlImage);
      }
      print('Cambios CORRECTOS!');
      return "Email cambiado!";
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }




  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }




}