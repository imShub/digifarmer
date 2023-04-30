import 'package:digi_farmer/datas/category_json.dart';
import 'package:digi_farmer/pages/crops_page.dart';
import 'package:digi_farmer/theme/padding.dart';
import 'package:digi_farmer/widget/clipper.dart';
import 'package:digi_farmer/widget/custom_category_card.dart';
import 'package:digi_farmer/widget/custom_heading.dart';
import 'package:digi_farmer/widget/custom_search_feild.dart';
import 'package:digi_farmer/widget/custom_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/cloudasset/v1.dart';

class HomePage extends StatefulWidget {
  final User? user;

  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: ,
        ));
    super.dispose();
  }

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
    var userName = widget.user?.displayName!.split(' ');
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
                        CustomHeading(
                          // title: 'Hi, ${userName[0]}!',
                          title:
                              'Hi,${userName != null ? userName[0] + " !" : " Shubham"}',
                          subTitle: 'Let\'s start prediction.',

                          color: Colors.white,
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
                                  : AssetImage("assets/images/profile-pic.png")
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
                            builder: (context) => CropsPage(),
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

          const SizedBox(height: spacer - 10.0),
        ],
      ),
    );
  }
}
