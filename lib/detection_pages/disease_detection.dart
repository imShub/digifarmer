import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class DiseaseDetection extends StatefulWidget {
  final String title;

  const DiseaseDetection({super.key, required this.title});

  @override
  _DiseaseDetectionState createState() => _DiseaseDetectionState();
}

class _DiseaseDetectionState extends State<DiseaseDetection> {
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
      model: "assets/model/disease/cotton.tflite",
      labels: "assets/model/disease/cottonlabels.txt",
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
      backgroundColor: Color.fromARGB(255, 229, 243, 213),
      appBar: AppBar(
        title: Text(
          widget.title.toString() + " Disease",
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
              ? Container(
                  height: 300,
                  width: 300,
                )
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
                          ? Container()
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
