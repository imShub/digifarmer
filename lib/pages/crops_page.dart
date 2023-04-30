import 'package:digi_farmer/theme/padding.dart';
import 'package:digi_farmer/views/features_page.dart';
import 'package:digi_farmer/widget/category_card.dart';
import 'package:digi_farmer/widget/clipper.dart';
import 'package:digi_farmer/widget/custom_heading.dart';
import 'package:digi_farmer/widget/custom_search_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CropsPage extends StatefulWidget {
  final User? user;

  const CropsPage({super.key, this.user});

  @override
  State<CropsPage> createState() => _CropsPageState();
}

class _CropsPageState extends State<CropsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 243, 213),
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
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: spacer),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipPath(
                clipper: BottomClipper(),
                child: Container(
                    width: size.width,
                    height: 300.0,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 75, 117, 32),
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: appPadding, right: appPadding),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: spacer),
                    //heading
                    const Text(
                      "Welcome to",
                      style: TextStyle(
                          color: Color.fromARGB(255, 167, 221, 113),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Crops Category",
                      style: TextStyle(
                        color: Color.fromARGB(255, 161, 207, 115),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: spacer),

                    // search
                    const CustomSearchField(
                      hintField: 'Try "Rice"',
                      backgroundColor: Color.fromARGB(255, 203, 233, 176),
                    ),
                    // const SizedBox(height: spacer - 35),
                    Column(
                      children: [
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: .84,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          children: <Widget>[
                            CategoryCard(
                              title: "Rice",
                              imgSrc: "assets/images/rice.png",
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FeaturesPage(
                                          title: "Rice",
                                          imgSrc: "assets/images/rice.png"),
                                    ));
                              },
                            ),
                            CategoryCard(
                              title: "Wheat",
                              imgSrc: "assets/images/wheat(1).png",
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FeaturesPage(
                                          title: "Wheat",
                                          imgSrc: "assets/images/wheat(1).png"),
                                    ));
                              },
                            ),
                            CategoryCard(
                              title: "Cotton",
                              imgSrc: "assets/images/cotton.png",
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FeaturesPage(
                                          title: "Cotton",
                                          imgSrc: "assets/images/cotton.png"),
                                    ));
                              },
                            ),
                            CategoryCard(
                              title: "Sugarcane",
                              fSize: 18,
                              imgSrc: "assets/images/sugar-cane.png",
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FeaturesPage(
                                          title: "Sugarcane",
                                          imgSrc:
                                              "assets/images/sugar-cane.png"),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
