import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

getProfileImage() {
    if(_auth.currentUser?.photoURL != null) {
      return Image.network(_auth.currentUser!.photoURL!, height: 100, width: 100);
    } else {
      return const Icon(Icons.account_circle, size: 100);
    }
  }
 

  Future signInwithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = credential.user;
      return firebaseUser;
    } catch (e) {
      log(e.toString());
    }
  }

  Future signUpwithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebseUser = credential.user;
      return firebseUser;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<User?> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return (await _auth.signInWithCredential(credential)).user;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }



  // Future resetPass(String email) async {
  //   try {
  //     return await _auth.sendPasswordResetEmail(email: email);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // Future sigOut() async {
  //   HelperFunctions.saveUserLoggedInSharedPreference(false);
  //   try {
  //     _googleSignIn.signOut();
  //     return await _auth.signOut();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}