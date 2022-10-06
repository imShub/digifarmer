import 'package:demo_hackit/datas/category_json.dart';
import 'package:demo_hackit/theme/padding.dart';
import 'package:demo_hackit/widget/clipper.dart';
import 'package:demo_hackit/widget/custom_category_card.dart';
import 'package:demo_hackit/widget/custom_heading.dart';
import 'package:demo_hackit/widget/custom_search_feild.dart';
import 'package:demo_hackit/widget/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  final GoogleSignInAccount? user;

  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 255, 185),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    var userName = widget.user?.displayName!.split(' ');
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
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 75, 117, 32),
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: appPadding, right: appPadding),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: spacer + 24),

                    //heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomHeading(
                          // title: 'Hi, ${userName[0]}!',
                          title: 'Hi,${userName != null ? userName : " User"}',
                          subTitle: 'Let\'s start prediction.',

                          color: Colors.white,
                        ),
                        Container(
                            height: spacer,
                            width: spacer,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  // UserProfile['image'].toString(),
                                  'assets/images/user.png',
                                  fit: BoxFit.cover,
                                  color: Colors.white,
                                ))),
                      ],
                    ),
                    SizedBox(height: spacer),

                    // search
                    CustomSearchField(
                      hintField: 'Try "Yeild Prediction"',
                      backgroundColor: Color.fromARGB(255, 178, 212, 145),
                    ),
                    SizedBox(height: spacer - 30.0),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
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
          SizedBox(height: smallSpacer),
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
                    onTap: () {},
                    child: CustomCourseCardExpand(
                      thumbNail: data['image'],
                      title: data['title'],
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: spacer - 20.0),

          SizedBox(height: spacer - 10.0),
        ],
      ),
    );
  }
}