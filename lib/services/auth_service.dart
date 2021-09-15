import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/pages/home.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

Future<bool> firebaseSignUp(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      log('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      log('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    log('$e');
    return false;
  }
}

Future<bool?> firebaseSignIn(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      log('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      log('Wrong password provided for that user.');
    }
    return false;
  }
}

void signIn({required String username, required String password, required BuildContext context}) {
  firebaseSignIn(username, password).then((result) {
    if (result!) {
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Signed in"),
      ));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      // show error in snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cannot sign in"),
        backgroundColor: Colors.red,
      ));
    }
  });
}

void signUp({required String displayName, required String username, required String password, required BuildContext context}) {
  firebaseSignUp(username, password).then((result) {
    if (result) {
      // update displayname
      firebaseAuth.currentUser!.updateDisplayName(displayName);
      // check user is exist in firestore
      firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).get().then((doc) {
        if (!doc.exists) {
          // insert new user data to firestore
          firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).set({
            'uid': firebaseAuth.currentUser!.uid,
            'displayName': displayName,
          });
        }
      });
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Signed up"),
      ));
      // goto home page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      // show error message in snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cannot sign up"),
        backgroundColor: Colors.red,
      ));
    }
  });
}
