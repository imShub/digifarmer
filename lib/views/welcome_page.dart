import 'package:demo_hackit/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/routes.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool changeBtn = false;

  moveToHome(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 178, 212, 145),
        // appBar: AppBar(title: Text("Farm.io"),centerTitle: true,backgroundColor: Colors.cyan,),
        body: Column(
          children: [
            Container(
              width: w,
              height: h * 0.55,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/farming_welcome_2-removebg.png"),
                    fit: BoxFit.cover),
              ),
            ),
            // Image.asset(
            //   "assets/images/farming_welcome_2.jpg",
            //   fit: BoxFit.cover,
            // ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: w * 0.9,
              padding: EdgeInsets.only(left: 10, top: 10),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "An Iniciative towards",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xff446129),
                    // fontFamily: const GoogleFonts.openSans().fontFamily,
                    fontFamily: 'Montserrat',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Container(
              width: w * 0.9,
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Smart Farming",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    // fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontFamily: 'Montserrat',
                    height: 1.2,
                    // overflow: TextOverflow.visible,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 10, right: 10),
                child: Text(
                  "lorem isum dolror ammmet lorem isum dolror ammmet lorem isum dolror ammmet",
                  textWidthBasis: TextWidthBasis.longestLine,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  style: TextStyle(
                    color: Color(0xff446129),
                    // fontFamily: 'ConcertOne-',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Material(
                  color: Color(0xff446129),
                  borderRadius: BorderRadius.circular(changeBtn ? 50 : 30),
                  child: InkWell(
                    onTap: () => moveToHome(context),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: changeBtn ? 50 : 150,
                      height: 60,
                      alignment: Alignment.center,
                      child: changeBtn
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : const Text(
                              "Get Started",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
}
