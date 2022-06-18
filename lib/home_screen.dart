import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signup_firebase/authentication.dart';

import 'login.dart';

class HomeScreen extends StatefulWidget {
  XFile? image;

  HomeScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isFlag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            
            padding: const EdgeInsets.only(top: 150),
            child: CircleAvatar(
              backgroundImage: widget.image != null
                  ? FileImage(File(widget.image!.path))
                  : null,
              radius: 100,
            ),
          ),
          AuthenticationHelper().getProfileImage(),
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
          )),
        ],
      ),
    );
  }
}
