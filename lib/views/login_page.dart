import 'package:demo_hackit/api/google_sign_in.dart';
import 'package:demo_hackit/pages/home_page.dart';
import 'package:demo_hackit/views/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Duration animationDuration = Duration(milliseconds: 250);
  late Animation<double> containerSize;
  bool isLogin = true;

  bool passHide = true;

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
        backgroundColor: Color.fromARGB(255, 178, 212, 145),
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
                  color: Color.fromARGB(255, 133, 170, 96),
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
                  color: Color.fromARGB(255, 133, 170, 96),
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
                    icon: Icon(Icons.cancel),
                    color: Color.fromARGB(255, 207, 235, 180),
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
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        width: w * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const TextField(
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
                            horizontal: 20, vertical: 5),
                        width: w * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: TextField(
                          obscureText: passHide,
                          cursorColor: Color.fromARGB(255, 178, 212, 145),
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock,
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
                                color: Color.fromARGB(255, 133, 170, 96)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {},
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
                            onTap: () {},
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: signIn,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        ),
                      ),
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
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: w * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: const TextField(
                            cursorColor: Color.fromARGB(255, 178, 212, 145),
                            decoration: InputDecoration(
                              icon: Icon(Icons.face_outlined,
                                  color: Color.fromARGB(255, 178, 212, 145)),
                              hintText: "Name",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          width: w * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: const TextField(
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
                              horizontal: 20, vertical: 5),
                          width: w * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: TextField(
                            obscureText: passHide,
                            cursorColor: Color.fromARGB(255, 178, 212, 145),
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock,
                                  color: Color.fromARGB(255, 178, 212, 145)),
                              hintText: "Password",
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    //add Icon button at end of TextField
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
                                  color: Color.fromARGB(255, 133, 170, 96)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: w * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 133, 170, 96),
                              border:
                                  Border.all(width: .5, color: Colors.white),
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
        decoration: BoxDecoration(
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
              ? Text(
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
          builder: (context) => RootApp(user: user),
        ),
      );
    }
  }
}
