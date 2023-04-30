import 'package:digi_farmer/detection_pages/crop_quality.dart';
import 'package:digi_farmer/detection_pages/disease_detection.dart';
import 'package:digi_farmer/detection_pages/weed_detection.dart';
import 'package:digi_farmer/detection_pages/yeild_prediction.dart';
import 'package:digi_farmer/pages/account_page.dart';
import 'package:digi_farmer/pages/home_page.dart';
import 'package:digi_farmer/theme/padding.dart';
import 'package:digi_farmer/widget/clipper.dart';
import 'package:digi_farmer/widget/features_card.dart';
import 'package:flutter/material.dart';

class FeaturesPage extends StatefulWidget {
  final String title;
  final String imgSrc;

  const FeaturesPage({super.key, required this.title, required this.imgSrc});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 243, 213),
      appBar: AppBar(
        title: Text(
          widget.title.toString() + " Features",
        ),
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 75, 117, 32),
        foregroundColor: Color.fromARGB(255, 166, 231, 101),
        // centerTitle: true,
        // ignore: prefer_const_literals_to_create_immutables
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: spacer),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: BottomClipper(),
                child: Container(
                    width: size.width,
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 75, 117, 32),
                    )),
              ),
              Center(
                child: Container(
                  width: size.width * 0.3,
                  height: size.height * 0.2,
                  // color: Color.fromARGB(255, 224, 224, 224).withOpacity(0.5),
                  child: Hero(
                    tag: widget.imgSrc.toString(),
                    child: Image.asset(widget.imgSrc),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: spacer,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CropQuality(
                      title: widget.title,
                      category: widget.title,
                    ),
                  ));
            },
            child: FeaturesCard(
              icon: Icon(
                Icons.image_search,
                size: 38,
                color: Color.fromARGB(255, 161, 207, 115),
              ),
              title: " Crop Quality",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YieldPrediction(
                      title: widget.title,
                      category: widget.title,
                    ),
                  ));
            },
            child: FeaturesCard(
              icon: Icon(
                Icons.online_prediction,
                size: 38,
                color: Color.fromARGB(255, 161, 207, 115),
              ),
              title: " Yeild Prediction",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiseaseDetection(
                      title: widget.title,
                      category: widget.title,
                    ),
                  ));
            },
            child: FeaturesCard(
              icon: Icon(
                Icons.medication,
                size: 38,
                color: Color.fromARGB(255, 161, 207, 115),
              ),
              title: " Disease Detection",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeedDetection(
                      title: widget.title,
                      category: widget.title,
                    ),
                  ));
            },
            child: FeaturesCard(
              icon: Icon(
                Icons.search_sharp,
                size: 38,
                color: Color.fromARGB(255, 161, 207, 115),
              ),
              title: " Weed Detection",
            ),
          ),
        ],
      ),
    );
  }
}
