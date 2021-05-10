import 'package:blue_car/models/anuncio.dart';
import 'package:blue_car/notifier/anuncio_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User> get authStateChanges => _auth.idTokenChanges();

  Future<String> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> login(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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

      await userCredential.user.updateProfile(displayName: name, photoURL: "https://firebasestorage.googleapis.com/v0/b/bluecar-eadb6.appspot.com/o/avatares%2Fimage12021-04-26%2019%3A18%3A01.011096?alt=media&token=270e2f4b-2b60-410a-8102-e93060829f7b");

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
        await _auth.currentUser.updateEmail(newEmail);
      }
      if(newPassword.isNotEmpty) {
        await _auth.currentUser.updatePassword(newPassword);
      }
      if(newName.isNotEmpty) {
        await _auth.currentUser.updateProfile(displayName: newName);
      }
      if(urlImage.isNotEmpty) {
        await _auth.currentUser.updateProfile(photoURL: urlImage);
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