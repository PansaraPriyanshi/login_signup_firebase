import 'dart:io';

import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_firebase/authentication.dart';

import 'login.dart';

class HomeScreen extends StatefulWidget {
  XFile? image;
  
  HomeScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          CircleAvatar(
            backgroundImage: widget.image !=null ? FileImage(File(widget.image!.path)): null,

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
            child: const Text("LogOut",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
          )),
        ],
      ),
    );
  }
}
