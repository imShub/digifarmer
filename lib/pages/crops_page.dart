import 'package:demo_hackit/theme/padding.dart';
import 'package:demo_hackit/widget/category_card.dart';
import 'package:demo_hackit/widget/clipper.dart';
import 'package:demo_hackit/widget/custom_heading.dart';
import 'package:demo_hackit/widget/custom_search_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CropsPage extends StatefulWidget {
  const CropsPage({super.key});

  @override
  State<CropsPage> createState() => _CropsPageState();
}

class _CropsPageState extends State<CropsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 229, 243, 213),
      // extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
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
              Padding(
                padding:
                    const EdgeInsets.only(left: appPadding, right: appPadding),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: spacer),

                    //heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome to",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 85, 121, 48),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Crops Data",
                              style: TextStyle(
                                color: Color.fromARGB(255, 81, 116, 46),
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spacer),

                    // search
                    const CustomSearchField(
                      hintField: 'Try "Rice"',
                      backgroundColor: Color.fromARGB(255, 203, 233, 176),
                    ),
                    SizedBox(height: spacer - 30.0),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: .85,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: <Widget>[
                          CategoryCard(
                            title: "Diet Recommendation",
                            imgSrc: "assets/icons/Hamburger.svg",
                            press: () {},
                          ),
                          CategoryCard(
                            title: "Kegel Exercises",
                            imgSrc: "assets/icons/Excrecises.svg",
                            press: () {},
                          ),
                          CategoryCard(
                            title: "Meditation",
                            imgSrc: "assets/icons/Meditation.svg",
                            press: () {},
                          ),
                          CategoryCard(
                            title: "Yoga",
                            imgSrc: "assets/icons/yoga.svg",
                            press: () {},
                          ),
                        ],
                      ),
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
