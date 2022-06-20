import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_firebase/authentication.dart';

import 'login.dart';

class HomeScreen extends StatefulWidget {
  final String? image;
  final String useName;

  const HomeScreen({Key? key, required this.image, required this.useName})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User _user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            children: [
              _user.providerData[0].providerId == 'google.com'
                  ? AuthenticationHelper().getProfileImage()
                  : Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: CircleAvatar(
                        backgroundImage: widget.image != null
                            ? FileImage(File(widget.image!))
                            : null,
                        radius: 100,
                      ),
                    ),
              Text(widget.useName),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      (context),
                      MaterialPageRoute(
                        builder: (context) => const LogIn(),
                      ),
                    );
                  },
                  child: const Text(
                    "LogOut",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
