import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  getProfileImage() {
    if (auth.currentUser?.photoURL != null) {
      return Image.network(auth.currentUser!.photoURL!,
          height: 100, width: 100);
    } else {
      return const Icon(Icons.account_circle, size: 100);
    }
  }

  Future signInwithEmailAndPassword(
      String email, String password, context) async {
    try {
      log('signInwithEmailAndPassword');
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      log('signInwithEmailAndPassword');

      User? firebaseUser = credential.user;
      log(firebaseUser.toString());

      return firebaseUser;
    } catch (e) {
      log(e.toString());
    }
  }

  Future signUpwithEmailAndPassword(
      String email, String password, context) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? firebseUser = credential.user;
      return firebseUser;
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error Message"),
              content: Text(e.toString()),
            );
          });
      log(e.toString());
    }
  }

  Future<User?> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      log(credential.toString());

      return (await auth.signInWithCredential(credential)).user;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
