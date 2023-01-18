import 'package:control_emission/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in with email password//
  Future signInWithEmailPassword(context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        e.message,
        style: TextStyle(color: Colors.white),
      )));
      return null;
    }
  }

//Sign up with email password//
  Future signUpWithEmailPassword(context, String email, String password,String name) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        e.message,
        style: TextStyle(color: Colors.white),
      )));
    }
  }

//Sign out //

  Future signOut(context)async{
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.message,
            style: TextStyle(color: Colors.white),
          )));
    }

  }

  void customSnackBarMessenger(context,String text){

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.grey.shade300,
        duration: Duration(seconds: 1),
        content: Row(
          children:  [
            SizedBox(
              width: 20,
            ),
            CircularProgressIndicator.adaptive(
              backgroundColor: Color(0xff004040),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )));

  }
}
