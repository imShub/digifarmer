import 'dart:convert';

import 'package:digi_farmer/theme/padding.dart';
import 'package:digi_farmer/widget/custom_heading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class YieldPrediction extends StatefulWidget {
  final String title;
  final String category;

  const YieldPrediction(
      {super.key, required this.title, required this.category});

  @override
  State<YieldPrediction> createState() => _YieldPredictionState();
}

class _YieldPredictionState extends State<YieldPrediction> {
  final districtNameController = TextEditingController();
  final seasonNameController = TextEditingController();
  final areaNameController = TextEditingController();

  // Posting json to the server
  final url = "http://127.0.0.1:5000/jsonPost";
  void postData() async {
    final response = await post(Uri.parse(url), body: {
      "district": districtNameController,
      "season": seasonNameController,
      "area": areaNameController,
    });
  }

  //Getting json output from the server
  var _postsJson;
  var img;
  final url2 = "http://127.0.0.1:5000/dataupload";
  void fetchPosts() async {
    final response2 = await get(Uri.parse(url2));
    final jsonData = jsonDecode(response2.body);
    final imagefile = Image.network("http://127.0.0.1:5000/yieldimg/img.png");
    setState(() {
      _postsJson = jsonData;
      img = imagefile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterTop,
        backgroundColor: Color.fromARGB(255, 229, 243, 213),
        appBar: AppBar(
          title: Text(
            widget.title.toString() + " Yield Prediction",
          ),
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 75, 117, 32),
          foregroundColor: Color.fromARGB(255, 166, 231, 101),
          // centerTitle: true,
          // ignore: prefer_const_literals_to_create_immutables
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: CustomHeading(
                  title: widget.title + " Yield Prediction",
                  subTitle: "",
                  color: Color.fromARGB(255, 75, 117, 32)),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: districtNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'District Name',
                        hintText: 'Enter Your District Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: seasonNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Season Name',
                        hintText: 'Enter the Season Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: areaNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Area Name',
                        hintText: 'Enter Your Area Name',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: spacer,
                  ),
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: postData,
                  ),
                  img != null ? img : Container(),
                ],
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }
}
