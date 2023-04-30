import 'dart:io';

import 'package:digi_farmer/api/google_sign_in.dart';
import 'package:digi_farmer/pages/home_page.dart';
import 'package:digi_farmer/util/auth_methods.dart';
import 'package:digi_farmer/util/authentication.dart';
import 'package:digi_farmer/views/root_app.dart';
import 'package:digi_farmer/widget/custom_google_sign_in_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:firebase_auth/firebase_auth.dart';

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
  bool isLogin = true;

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
              top: -70,
              left: -70,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 133, 170, 96),
                ),
              ),
            ),

            // Cancel Button
            AnimatedOpacity(
              opacity: isLogin ? 0.0 : 1.0,
              duration: animationDuration,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: w,
                  height: h * 0.1,
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    onPressed: isLogin
                        ? null
                        : () {
                            setState(() {
                              animationController.reverse();
                              isLogin = !isLogin;
                            });
                          },
                    icon: const Icon(Icons.cancel),
                    color: const Color.fromARGB(255, 207, 235, 180),
                    iconSize: 38,
                  ),
                ),
              ),
            ),

            //Login Form
            AnimatedOpacity(
              opacity: isLogin ? 1.0 : 0.0,
              duration: animationDuration * 3,
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Color.fromARGB(255, 97, 131, 63),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: w,
                        height: h * 0.3,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/farmer-holding-tablet.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        width: w * 0.8,
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
                        // onTap: _logInUser,
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RootApp(
                                      user: null,
                                    ),
                                  ));
                            },
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
                      SizedBox(
                        height: 15,
                      ),
                      FutureBuilder(
                          future: Authentication.initializeFirebase(
                              context: context),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error initializing Firebase');
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return GoogleSignInButton();
                            }
                            return CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                CustomColors.firebaseOrange,
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Register Container
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                if (viewInset == 0 && isLogin) {
                  return buildRegisterContainer();
                } else if (!isLogin) {
                  return buildRegisterContainer();
                }
                return Container();
              },
            ),

            //Register Form
            AnimatedOpacity(
              opacity: isLogin ? 0.0 : 1.0,
              duration: animationDuration * 4,
              child: Visibility(
                visible: !isLogin,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
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
                        Container(
                          width: w * 0.6,
                          height: h * 0.2,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/farmer-holding-tablet.png"),
                              fit: BoxFit.cover,
                            ),
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
                                        color:
                                            Color.fromARGB(255, 178, 212, 145)),
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
                                  cursorColor:
                                      Color.fromARGB(255, 178, 212, 145),
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.account_box,
                                        color:
                                            Color.fromARGB(255, 178, 212, 145)),
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
                                  cursorColor:
                                      Color.fromARGB(255, 178, 212, 145),
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.email,
                                        color:
                                            Color.fromARGB(255, 178, 212, 145)),
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
                                  cursorColor:
                                      const Color.fromARGB(255, 178, 212, 145),
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.lock,
                                        color:
                                            Color.fromARGB(255, 178, 212, 145)),
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
                                        color: const Color.fromARGB(
                                            255, 133, 170, 96)),
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
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Container(
                                  width: w * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color:
                                        const Color.fromARGB(255, 133, 170, 96),
                                    border: Border.all(
                                        width: .5, color: Colors.white),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
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
          onTap: !isLogin
              ? null
              : () {
                  setState(() {
                    animationController.forward();
                    isLogin = !isLogin;
                  });
                },
          child: isLogin
              ? const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                      color: Color.fromARGB(255, 97, 131, 63), fontSize: 18),
                )
              : null,
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

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      // Logging in the user w/ Firebase
      String result = await AuthMethods().signUpUser(
          name: _name, email: _email, password: _password, username: _userName);
      if (result != 'success') {
        showSnackBar(result, context);
      } else {
        Navigator.pop(context);
      }
      setState(() {
        _isLoading = false;
      });
    }
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
    if (result == 'successs') {
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
