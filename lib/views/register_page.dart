import 'dart:io';

import 'package:digi_farmer/util/auth_methods.dart';
import 'package:digi_farmer/views/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLogin = false;
  bool passHide = true;

  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  String? _userName;
  late int _phone;
  bool _isLoading = false;
  File? _profileImage;
  bool _isUploading = false;
  String? _profileImageUrl;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 178, 212, 145),
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color.fromARGB(255, 146, 173, 118),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Welcome To Our App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Color.fromARGB(255, 97, 131, 63),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _pickProfilePicture,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Color.fromARGB(255, 178, 212, 145),
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      width: w * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 26, 26, 26),
                        decoration: InputDecoration(
                          icon: Icon(Icons.face_outlined,
                              color: Color.fromARGB(255, 178, 212, 145)),
                          border: InputBorder.none,
                          labelText: "Name",
                        ),
                        validator: (input) => input!.trim().isEmpty
                            ? 'Please enter a valid name'
                            : null,
                        onSaved: (input) => _name = input!,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      width: w * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 178, 212, 145),
                        decoration: InputDecoration(
                          icon: Icon(Icons.account_box,
                              color: Color.fromARGB(255, 178, 212, 145)),
                          labelText: "Username",
                          border: InputBorder.none,
                        ),
                        validator: (input) => input!.trim().isEmpty
                            ? 'Please enter a valid username'
                            : null,
                        onSaved: (input) => _userName = input!,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      width: w * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        cursorColor: Color.fromARGB(255, 178, 212, 145),
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ], // Only numbers can be entered

                        decoration: InputDecoration(
                          icon: Icon(Icons.account_box,
                              color: Color.fromARGB(255, 178, 212, 145)),
                          labelText: "Phone",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter a Phone Number";
                          } else if (!RegExp(
                                  r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                              .hasMatch(value)) {
                            return "Please Enter a Valid Phone Number";
                          }
                        },

                        onChanged: (value) => _phone = int.parse(value),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      width: w * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color.fromARGB(255, 178, 212, 145),
                        decoration: InputDecoration(
                          icon: Icon(Icons.email,
                              color: Color.fromARGB(255, 178, 212, 145)),
                          labelText: "Email",
                          border: InputBorder.none,
                        ),
                        validator: (input) => !input!.contains('@')
                            ? 'Please enter a valid email'
                            : null,
                        onSaved: (input) => _email = input!,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      width: w * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        obscureText: passHide,
                        cursorColor: const Color.fromARGB(255, 178, 212, 145),
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock,
                              color: Color.fromARGB(255, 178, 212, 145)),
                          labelText: "Password",
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
                                //add Icon button at end of TextFormField
                                setState(() {
                                  //refresh UI
                                  if (passHide) {
                                    passHide = false;
                                  } else {
                                    passHide = true;
                                  }
                                });
                              },
                              icon: Icon(passHide == true
                                  ? Icons.remove_red_eye
                                  : Icons.password),
                              color: const Color.fromARGB(255, 133, 170, 96)),
                        ),
                        validator: (input) => input!.length < 6
                            ? 'Must be at least 6 characters'
                            : null,
                        onSaved: (input) => _password = input!,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => _signUp(),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: w * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 133, 170, 96),
                    border: Border.all(width: .5, color: Colors.white),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickProfilePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_profileImage != null) {
        setState(() {
          _isUploading = true;
        });

        // Upload profile picture to Firebase Storage
        String imageUrl = await _uploadProfilePicture();

        setState(() {
          _isUploading = false;
          _profileImageUrl = imageUrl;
        });
      }

      setState(() {
        _isLoading = true;
      });

      // Logging in the user w/ Firebase
      String result = await AuthMethods().signUpUser(
        name: _name,
        email: _email,
        password: _password,
        username: _userName,
        phone: _phone,
        profileImageUrl: _profileImageUrl,
      );

      if (result != 'success') {
        showSnackBar(result, context);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        print(result);
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> _uploadProfilePicture() async {
    if (_profileImage == null) return '';

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final destination = 'profile_pictures/$fileName';

    try {
      final firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref(destination);
      final task = ref.putFile(_profileImage!);
      final snapshot = await task;

      if (snapshot.state == firebase_storage.TaskState.success) {
        final imageUrl = await snapshot.ref.getDownloadURL();
        return imageUrl;
      }
    } catch (error) {
      print('Error uploading profile picture: $error');
    }

    return '';
  }

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  _showEmptyDialog(String title) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          content: Text("$title can't be empty"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            )
          ],
        ),
      );
    } else if (Platform.isIOS) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: Text("$title can't be empty"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            )
          ],
        ),
      );
    }
  }
}
