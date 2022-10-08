import 'package:demo_hackit/theme/padding.dart';
import 'package:demo_hackit/widget/custom_heading.dart';
import 'package:flutter/material.dart';

class YieldPrediction extends StatefulWidget {
  final String title;
  final String category;

  const YieldPrediction(
      {super.key, required this.title, required this.category});

  @override
  State<YieldPrediction> createState() => _YieldPredictionState();
}

class _YieldPredictionState extends State<YieldPrediction> {
  final TextEditingController districtNameController = TextEditingController();
  final TextEditingController seasonNameController = TextEditingController();
  final TextEditingController areaNameController = TextEditingController();

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
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
