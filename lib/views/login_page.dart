import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 178, 212, 145),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: w * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: const TextField(
                      cursorColor: Color.fromARGB(255, 178, 212, 145),
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock,
                            color: Color.fromARGB(255, 178, 212, 145)),
                        hintText: "Password",
                        border: InputBorder.none,
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
                      child: const Text(
                        "LOGIN",
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
        ],
      ),
    );
  }
}
