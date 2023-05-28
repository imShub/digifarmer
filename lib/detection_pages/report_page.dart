import 'dart:io';
import 'dart:ui';

import 'package:digi_farmer/datas/disease_info.dart';
import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';

final globalKey = GlobalKey();

class CropReport extends StatelessWidget {
  final String diseaseName;

  const CropReport({super.key, required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    final disease = cropDiseases[diseaseName];

    // print(disease);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disease Info"),
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 75, 117, 32),
        foregroundColor: const Color.fromARGB(255, 166, 231, 101),
      ),
      body: RepaintBoundary(
        key: globalKey, // Add a global key to the RepaintBoundary widget
        child: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              ListTile(
                minVerticalPadding: 2,
                title: Center(
                    child: Text(
                  diseaseName.toString().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                )),
              ),
              ListTile(
                title: const Text('Symptoms'),
                subtitle:
                    Text(addBulletPoints(disease!["Symptoms"].toString())),
              ),
              ListTile(
                title: const Text('Causes'),
                subtitle: Text(disease["Cause"].toString()),
              ),
              ListTile(
                title: const Text('Comments'),
                subtitle: Text(disease["Comments"].toString()),
              ),
              ListTile(
                title: const Text('Management Techniques'),
                subtitle:
                    Text(addBulletPoints(disease["Management"].toString())),
              ),
            ],
          ),
        ), // Your text widget goes here
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          generatePDF();
        },
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 75, 117, 32),
        foregroundColor: const Color.fromARGB(255, 166, 231, 101),
        child: const Icon(Icons.file_download),
      ),
    );
  }

  String addBulletPoints(String text) {
    List<String> segments = text.split(';');
    List<String> bulletPoints = [];

    for (String segment in segments) {
      bulletPoints.add('• $segment');
    }

    return bulletPoints.join('\n');
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    // Get the boundary of the RepaintBoundary widget
    final boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary != null) {
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final pdfImage = pw.MemoryImage(pngBytes);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(pdfImage),
            );
          },
        ),
      );

      // Add the image of the text to the PDF
      // pdf.addPage(
      //   pw.Page(
      //     build: (pw.Context context) {
      //       return pw.Center(
      //         child: pw.Image(pw.MemoryImage(pngBytes)),
      //       );
      //     },
      //   ),
      // );

      // Get the document directory path
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;

      // Save the PDF file
      final file = File('$path/example.pdf');
      await file.writeAsBytes(await pdf.save());

      // Open the PDF file
      // Note: You can use any PDF viewer app installed on the device to open the PDF file
      // For example, you can use the 'open_file' package to open the PDF using the default PDF viewer app
      // Make sure to add the 'open_file' package to your pubspec.yaml file
      // import 'package:open_file/open_file.dart';
      // await OpenFile.open(file.path);
    }
  }
}
