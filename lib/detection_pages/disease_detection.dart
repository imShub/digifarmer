import 'dart:io';

import 'package:digi_farmer/detection_pages/report_page.dart';
import 'package:digi_farmer/theme/padding.dart';
import 'package:digi_farmer/util/model_locations.dart';
import 'package:digi_farmer/widget/custom_heading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class DiseaseDetection extends StatefulWidget {
  final String title;
  final String category;

  const DiseaseDetection(
      {super.key, required this.title, required this.category});

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
    if (widget.category == "Rice") {
      await Tflite.loadModel(
        model: MyModels.riceDiseaseModel,
        labels: MyModels.riceDiseasetxt,
        numThreads: 1,
      );
    } else if (widget.category == "Wheat") {
      await Tflite.loadModel(
        model: MyModels.wheatDiseaseModel,
        labels: MyModels.wheatDiseasetxt,
        numThreads: 1,
      );
    } else if (widget.category == "Cotton") {
      await Tflite.loadModel(
        model: MyModels.cottonDiseaseModel,
        labels: MyModels.cottonDiseasetxt,
        numThreads: 1,
      );
    } else if (widget.category == "Sugarcane") {
      await Tflite.loadModel(
        model: MyModels.sugarcaneDiseaseModel,
        labels: MyModels.sugarcaneDiseasetxt,
        numThreads: 1,
      );
    }
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
      backgroundColor: const Color.fromARGB(255, 229, 243, 213),
      appBar: AppBar(
        title: Text(
          widget.title.toString() + " Disease",
        ),
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 75, 117, 32),
        foregroundColor: const Color.fromARGB(255, 166, 231, 101),
        // centerTitle: true,
        // ignore: prefer_const_literals_to_create_immutables
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: _image == null
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _image == null ? Container() : Image.file(_image!),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Disease Name:  "),
                                _image == null
                                    ? Visibility(
                                        child: Container(),
                                        visible: false,
                                      )
                                    : _outputs != null
                                        ? Text(
                                            _outputs![0]["label"]
                                                .toString()
                                                .toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          )
                                        : Container(child: const Text("")),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton.icon(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CropReport(
                                      diseaseName: _outputs![0]["label"]),
                                ),
                              ),
                              icon: const Icon(Icons.info),
                              label: const Text("See More Info"),
                              style: const ButtonStyle(),
                            ),
                          ],
                        ),
                ),
          !_loading && _image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CustomHeading(
                          subTitle:
                              " to Detect Disease in ${widget.title} Crops",
                          title: "Select an Image",
                          color: const Color.fromARGB(255, 75, 117, 32)),
                    ),
                    const SizedBox(height: spacer * 0.5),
                    FloatingActionButton(
                      tooltip: 'Pick Image',
                      onPressed: pickImage,
                      child: const Icon(
                        Icons.add_a_photo,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Container(
                  height: smallSpacer,
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
