import 'package:digi_farmer/util/authentication.dart';
import 'package:digi_farmer/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../datas/category_json.dart';
import '../theme/padding.dart';
import '../widget/clipper.dart';
import '../widget/custom_category_card.dart';
import '../widget/custom_heading.dart';
import '../widget/custom_search_feild.dart';
import '../widget/custom_title.dart';
import 'crops_page.dart';

class LoggedInWidget extends StatefulWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  State<LoggedInWidget> createState() => _LoggedInWidget();
}

class _LoggedInWidget extends State<LoggedInWidget> {
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: ,
        ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user);
    print(widget.user?.displayName);

    var size = MediaQuery.of(context).size;
    var userName = widget.user?.displayName?.split(' ');
    var userPicUrl = widget.user?.photoURL;
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
                    const SizedBox(height: spacer + 24),

                    //heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CustomHeading(
                              // title: 'Hi, ${userName[0]}!',
                              title:
                                  'Hi,${userName != null ? userName[0] + " !" : " Shubham"}',
                              subTitle: 'Let\'s start prediction.',

                              color: Colors.white,
                            ),
                            // ElevatedButton.icon(
                            //   onPressed: _logOut,
                            //   icon: const Icon(Icons.logout),
                            //   label: const Text("Logout"),
                            // ),
                          ],
                        ),
                        Container(
                          height: 85,
                          width: 85,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60,
                              // maxRadius: 80,
                              foregroundImage: userPicUrl.toString() == null
                                  ? NetworkImage(userPicUrl.toString())
                                  : const AssetImage(
                                          "assets/images/profile-pic.png")
                                      as ImageProvider,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: spacer),
                    // search
                    const CustomSearchField(
                      hintField: 'Try "Disease Detection"',
                      backgroundColor: Color.fromARGB(255, 203, 233, 176),
                    ),
                    const SizedBox(height: spacer - 30.0),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: smallSpacer,
          ),
          //feature courses
          const Padding(
            padding: EdgeInsets.only(left: appPadding, right: appPadding),
            child: CustomTitle(
              title: 'Feature Functions',
              arg: {
                'title': 'Feature Functions!',
                'list': CoursesJson,
              },
            ),
          ),
          const SizedBox(height: smallSpacer),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: appPadding,
              right: appPadding - 10.0,
            ),
            child: Wrap(
              children: List.generate(CoursesJson.length, (index) {
                var data = CoursesJson[index];

                return Padding(
                  padding: const EdgeInsets.only(right: 15.0, bottom: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CropsPage(),
                          ));
                    },
                    child: CustomCourseCardExpand(
                      thumbNail: data['image'],
                      title: data['title'],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: spacer - 20.0),
        ],
      ),
    );
  }

  Future<void> _logOut() async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();

    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
