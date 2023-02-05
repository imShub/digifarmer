import 'dart:io';

import 'package:digi_farmer/theme/padding.dart';
import 'package:digi_farmer/util/model_locations.dart';
import 'package:digi_farmer/widget/custom_heading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class WeedDetection extends StatefulWidget {
  final String title;
  final String category;

  const WeedDetection({super.key, required this.title, required this.category});

  @override
  WeedDetectionState createState() => WeedDetectionState();
}

class WeedDetectionState extends State<WeedDetection> {
  List? _outputs;
  File? _image;
  bool _loading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: MyModels.weedDetectionModel,
      labels: MyModels.weedDetectiontxt,
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future pickImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      backgroundColor: Color.fromARGB(255, 229, 243, 213),
      appBar: AppBar(
        title: Text(
          widget.title.toString() + " Weed Detection",
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
          _loading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  margin: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _image == null ? Container() : Image.file(_image!),
                      SizedBox(
                        height: 20,
                      ),
                      _image == null
                          ? Visibility(
                              child: Container(),
                              visible: false,
                            )
                          : _outputs != null
                              ? Text(
                                  _outputs![0]["label"],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )
                              : Container(child: Text(""))
                    ],
                  ),
                ),
          !_loading && _image == null
              ? Center(
                  child: CustomHeading(
                      subTitle: " to Detect Weed in ${widget.title} Crops",
                      title: "Select an Image",
                      color: Color.fromARGB(255, 75, 117, 32)),
                )
              : Container(
                  height: smallSpacer,
                ),
          SizedBox(height: spacer),
          FloatingActionButton(
            tooltip: 'Pick Image',
            onPressed: pickImage,
            child: Icon(
              Icons.add_a_photo,
              size: 20,
              color: Colors.white,
            ),
          ),
          // IconButton(
          //   onPressed: pickImage,
          //   icon: Icon(
          //     Icons.add_a_photo,
          //     size: 20,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
    );
  }
}
