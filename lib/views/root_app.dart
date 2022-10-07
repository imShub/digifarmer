import 'package:demo_hackit/pages/account_page.dart';
import 'package:demo_hackit/pages/crops_page.dart';
import 'package:demo_hackit/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RootApp extends StatefulWidget {
  final GoogleSignInAccount? user;

  const RootApp({super.key, this.user});

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      // ignore: prefer_const_constructors
      HomePage(user: widget.user),
      CropsPage(user: widget.user),
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
        borderRadius: BorderRadius.only(
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
                      SizedBox(
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
