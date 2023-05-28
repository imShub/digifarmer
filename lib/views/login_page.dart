import 'dart:io';

import 'package:digi_farmer/api/google_sign_in.dart';
import 'package:digi_farmer/pages/home_page.dart';
import 'package:digi_farmer/util/auth_methods.dart';
import 'package:digi_farmer/util/authentication.dart';
import 'package:digi_farmer/views/register_page.dart';
import 'package:digi_farmer/views/root_app.dart';
import 'package:digi_farmer/widget/custom_google_sign_in_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../util/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class CustomColors {
  static final Color firebaseNavy = Color(0xFF2C384A);
  static final Color firebaseOrange = Color(0xFFF57C00);
  static final Color firebaseAmber = Color(0xFFFFA000);
  static final Color firebaseYellow = Color(0xFFFFCA28);
  static final Color firebaseGrey = Color(0xFFECEFF1);
  static final Color googleBackground = Color(0xFF4285F4);
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Duration animationDuration = const Duration(milliseconds: 250);
  late Animation<double> containerSize;
  bool isLogin = false;

  bool passHide = true;

  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  String? _userName;
  bool _isLoading = false;

  final TextEditingController _emailIdController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  bool _isLoginLoading = false;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    animationController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultRegisterSize = h - (h * 0.1);

    containerSize = Tween<double>(begin: h * 0.1, end: defaultRegisterSize)
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.linear));

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
        body: Stack(
          children: [
            //Decoration
            Positioned(
              top: 100,
              right: -50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(255, 133, 170, 96),
                ),
              ),
            ),
            Positioned(
              top: -90,
              left: -90,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 133, 170, 96),
                ),
              ),
            ),

            //Login Form
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Sign in to DigiFarmer and continue",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Enter your email and password \nbelow to continue to the DigiFarmer and let's start prediction.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 97, 131, 63),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    // Container(
                    //   width: w * 0.6,
                    //   height: h * 0.3,
                    //   decoration: const BoxDecoration(
                    //     image: DecorationImage(
                    //       image: AssetImage(
                    //           "assets/images/farmer-holding-tablet.png"),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: w * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _emailIdController,
                        cursorColor: Color.fromARGB(255, 178, 212, 145),
                        decoration: InputDecoration(
                          icon: Icon(Icons.email,
                              color: Color.fromARGB(255, 178, 212, 145)),
                          hintText: "Email",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      width: w * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: passHide,
                        cursorColor: const Color.fromARGB(255, 178, 212, 145),
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock,
                              color: Color.fromARGB(255, 178, 212, 145)),
                          hintText: "Password",
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () {
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
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: _logInUser,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: w * 0.7,
                        margin: EdgeInsets.only(
                          top: 0,
                          bottom: 15,
                        ),
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(255, 133, 170, 96),
                          border: Border.all(width: .5, color: Colors.white),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: _logInUser,
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: Size(150, 50),
                        ),
                        icon:
                            FaIcon(FontAwesomeIcons.google, color: Colors.red),
                        label: Text("Sign Up with Google"),
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                        }),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "-OR-",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 133, 170, 96)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: containerSize.value,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100),
                        ),
                        color: Color.fromARGB(255, 200, 228, 176),
                      ),
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: const Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                              color: Color.fromARGB(255, 97, 131, 63),
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    final user = await GoogleSignInApi.login();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign In Failed"),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RootApp(user: null),
        ),
      );
    }
  }

  Future skipToMain() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const RootApp(),
      ),
    );
  }

  void _logInUser() async {
    if (_emailIdController.text.isEmpty) {
      _showEmptyDialog("Type something");
    } else if (_passwordController.text.isEmpty) {
      _showEmptyDialog("Type something");
    }
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().logInUser(
      email: _emailIdController.text,
      password: _passwordController.text,
    );
    if (result == 'success') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RootApp(),
          ));
      showSnackBar(result, context);
    } else {
      showSnackBar(result, context);
    }
    setState(() {
      _isLoading = false;
    });
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
                child: Text("OK"))
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
                child: Text("OK"))
          ],
        ),
      );
    }
  }
}
