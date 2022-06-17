import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_signup_firebase/authentication.dart';
import 'package:login_signup_firebase/home_screen.dart';
import 'package:login_signup_firebase/login.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // bool isChecked = false;

  ImagePicker imagePicker = ImagePicker();
 XFile? pickedFile;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  XFile? image;
  

  Future takeCameraPhoto(ImageSource camera) async {
    // final pickedFile;
    pickedFile = (await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100));

    if (pickedFile != null) {
      setState(() {
        pickedFile;
      });
    }
  }

  Future takeGalleryPhoto(ImageSource gallery) async {
    // final pickedFile;
    pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      setState(() {
        pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0, right: 25, left: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      // backgroundImage: pickedFile != null
                      //     ? FileImage(File(pickedFile!.path))
                      //     : null,
                      child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => bottomSheet(context));
                          },
                          child: pickedFile == null
                              ? const Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.black,
                                  size: 30,
                                )
                              : null),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Text(
                      "SignUp",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                    // onSaved: (value) {
                    //   email = value;
                    // },
                    decoration: const InputDecoration(hintText: "Email "),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    // onSaved: (value) {
                    //   password = value;
                    // },
                    decoration: const InputDecoration(hintText: "Password "),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: () => AuthenticationHelper()
                              .signUpwithEmailAndPassword(_emailController.text,
                                  _passwordController.text)
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreen(image: pickedFile)))),
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () => AuthenticationHelper()
                              .signUpWithGoogle()
                              .then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             HomeScreen(image: pickedFile,)),
                                  )),
                          child: const Text(
                            "SignUp with Google",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Row(
                      children: [
                        const Text("Already have an account?"),
                        const SizedBox(
                          width: 0.05,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              (context),
                              MaterialPageRoute(
                                builder: (context) => const LogIn(),
                              ),
                            );
                          },
                          child: const Text("LogIn"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.3,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Column(
        children: [
          const Text(
            "Choose your profile picture",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  takeGalleryPhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: Column(
                  children: const [
                    Icon(Icons.image),
                    Text(
                      "Gallery",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 80,
              ),
              InkWell(
                onTap: () {
                  takeCameraPhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: Column(
                  children: const [
                    Icon(Icons.camera),
                    Text(
                      "Camera",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
