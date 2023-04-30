import 'package:digi_farmer/pages/account_page.dart';
import 'package:digi_farmer/pages/crops_page.dart';
import 'package:digi_farmer/pages/home_page.dart';
import 'package:digi_farmer/pages/tips_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import '../pages/weather_page.dart';

class RootApp extends StatefulWidget {
  final User? user;

  const RootApp({super.key, this.user});

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  final List<IconData> iconList = [
    Icons.home,
    Icons.drafts,
    Icons.list,
    Icons.verified_user,
  ];

  final _pageController = PageController(initialPage: 0);

  int maxCount = 5;

  /// widget list
  final List<Widget> bottomBarPages = [
    // ignore: prefer_const_constructors
    HomePage(),
    TipsPage(),
    CropsPage(),
    WeatherPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: Color.fromARGB(255, 75, 117, 32),
              showLabel: true,
              itemLabelStyle: TextStyle(
                color: Color.fromARGB(255, 208, 255, 161),
                fontSize: 12,
              ),
              notchColor: Color.fromARGB(255, 75, 117, 32),
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Color.fromARGB(255, 199, 228, 165),
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Color.fromARGB(255, 199, 228, 165),
                  ),
                  itemLabel: 'Home',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.list_alt_outlined,
                    color: Color.fromARGB(255, 199, 228, 165),
                  ),
                  activeItem: Icon(
                    Icons.list_alt_outlined,
                    color: Color.fromARGB(255, 199, 228, 165),
                  ),
                  itemLabel: 'Tips',
                ),

                ///svg example
                BottomBarItem(
                  inActiveItem: Icon(
                    CupertinoIcons.tree,
                    color: Color.fromARGB(255, 199, 228, 165),
                  ),
                  activeItem: Icon(
                    CupertinoIcons.tree,
                    color: Color.fromARGB(255, 199, 228, 165),
                  ),
                  itemLabel: 'Crops',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    FontAwesomeIcons.cloudMoonRain,
                    color: Color.fromARGB(255, 199, 228, 165),
                  ),
                  activeItem: Icon(
                    FontAwesomeIcons.cloudMoonRain,
                    color: Color.fromARGB(255, 199, 228, 165),
                  ),
                  itemLabel: 'Weather',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.account_circle_outlined,
                    color: Color.fromARGB(255, 199, 228, 165),
                  ),
                  activeItem: Icon(
                    Icons.account_circle_outlined,
                    color: Color.fromARGB(255, 199, 228, 165),
                  ),
                  itemLabel: 'Account',
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      // ignore: prefer_const_constructors
      HomePage(user: widget.user),
      CropsPage(user: widget.user),
      TipsPage(),
      AccountPage(user: widget.user),
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    List bottomItems = [
      "assets/images/home.png",
      "assets/images/leaves.png",
      "assets/images/rainy-day.png",
      "assets/images/user.png",
    ];
    return Container(
      width: size.width,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 30.0,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 40, right: 40, bottom: 10, top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(bottomItems.length, (index) {
              return InkWell(
                  onTap: () {
                    selectedTab(index);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        bottomItems[index],
                        height: 18,
                        color: pageIndex == index
                            ? Color.fromARGB(255, 97, 131, 63)
                            : Colors.grey,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      (pageIndex == index)
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                              child: Container(
                                height: 5.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 97, 131, 63),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            )
                          : Container(
                              height: 5.0,
                              width: 20.0,
                            ),
                    ],
                  ));
            }),
          ),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
