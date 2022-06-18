import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // TextEditingController email = TextEditingController();
  // TextEditingController password = TextEditingController();

  getProfileImage() {
    if (_auth.currentUser?.photoURL != null) {
      return Image.network(_auth.currentUser!.photoURL!,
          height: 100, width: 100);
    } else {
      return const Icon(Icons.account_circle, size: 100);
    }
  }

  Future signInwithEmailAndPassword(
      String email, String password, context) async {
    try {
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return const AlertDialog(
      //         title: Center(
      //           child: CircularProgressIndicator(),
      //         ),
      //       );
      //     });
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pop(context);
      User? firebaseUser = credential.user;
      return firebaseUser;
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return  AlertDialog(
              title: const Text( "Error Message"),
            
              content: Text(e.toString()),
            );
          });
      log(e.toString());
    }
  }

  Future signUpwithEmailAndPassword(
      String email, String password, context) async {
    try {
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return const AlertDialog(
      //         title: Center(
      //           child: CircularProgressIndicator(),
      //         ),
      //       );
      //     });
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pop(context);
      User? firebseUser = credential.user;
      return firebseUser;
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return  AlertDialog(
              title: const Text( "Error Message"),
            
              content: Text(e.toString()),
            );
          });
      log(e.toString());
    }

    // try {
    //   final credential = await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: email, password: password);
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     print('Wrong password provided for that user.');
    //   }
    // }
  }

  // Future<bool> login(String email, String password) async {
  //   final user = (await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: email, password: password))
  //       .user;
  //   var isEmailVerified;
  //   if (user!.isEmailVerified) {
  //     return true;
  //   }
  //   return false;
  // }

  // Future register() async {
  //   await _auth
  //       .createUserWithEmailAndPassword(email: email.trim(), password: password)
  //       .then(
  //     (result) async {
  //       //send verifcation email
  //       result.user!.sendEmailVerification();
  //       return result.user;
  //     },
  //   );
  //   return null;
  // }

  Future<User?> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
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
