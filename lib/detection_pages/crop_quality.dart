import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class CropQuality extends StatefulWidget {
  final String title;
  final String category;

  const CropQuality({super.key, required this.title, required this.category});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CropQualityState();
  }
}

class CropQualityState extends State<CropQuality> {
  int type_of_crop = 0, soil_type = 0, pesticide_use = 0, pesticide_count = 0;
  double pesticide_week = 0;
  int count = 1;
  bool isLoading = false, result = false;
  int ans = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> questions = [
      Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.black,
                  backgroundImage: AssetImage(
                    'assets/images/app-logo.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 290,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 75, 117, 32),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              'What Type of Crop are you growing?',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: DropdownButton<int>(
                      value: type_of_crop,
                      items: const [
                        DropdownMenuItem(
                          value: 0,
                          child: Text("Food Crops"),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text("Cash Crops"),
                        ),
                      ],
                      onChanged: (int? value) {
                        setState(() {
                          type_of_crop = value!;
                        });
                      }),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    count = 2;
                    setState(() {});
                  },
                  child: const Text('OK'),
                )),
          )
        ],
      ),
      Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.black,
                  backgroundImage: AssetImage(
                    'assets/images/app-logo.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 290,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 75, 117, 32),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: Center(
                      child: Text(
                        'What Type of Soil are you using?',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 50,
                width: 225,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<int>(
                      value: soil_type,
                      items: const [
                        DropdownMenuItem(
                          value: 0,
                          child: Text("Alluvial Soil"),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text("Others(Red,Black etc)"),
                        ),
                      ],
                      onChanged: (int? value) {
                        setState(() {
                          soil_type = value!;
                        });
                      }),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    count = 3;
                    setState(() {});
                  },
                  child: const Text('OK'),
                )),
          )
        ],
      ),
      Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.black,
                  backgroundImage: AssetImage(
                    'assets/images/app-logo.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 220,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 75, 117, 32),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: Center(
                      child: Text(
                        'Do you use pesticides?',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 50,
                width: 170,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton<int>(
                        value: pesticide_use,
                        items: const [
                          DropdownMenuItem(
                            value: 0,
                            child: Text("Never"),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text("Previously Used"),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text("Currently Using"),
                          ),
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            pesticide_use = value!;
                          });
                        }),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    count = 4;
                    setState(() {});
                  },
                  child: const Text('OK'),
                )),
          )
        ],
      ),
      Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.black,
                  backgroundImage: AssetImage(
                    'assets/images/app-logo.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 290,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 75, 117, 32),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: Center(
                      child: Text(
                        'Pesticide count in a week? (0-100)',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                      pesticide_count = int.parse(value);
                    },
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    count = 5;
                    setState(() {});
                  },
                  child: const Text('OK'),
                )),
          )
        ],
      ),
      Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.black,
                  backgroundImage: AssetImage(
                    'assets/images/app-logo.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 290,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 75, 117, 32),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          '   How many weeks did you use pesticide?',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        pesticide_week = double.parse(value);
                      });
                    },
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () async {
                    isLoading = true;
                    ans = await getData();
                    result = true;
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    width: 350,
                    color: const Color.fromARGB(255, 75, 117, 32),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    ];
    Size size = MediaQuery.of(context).size;
    var height = size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.title} Crop Quality",
        ),
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 75, 117, 32),
        foregroundColor: const Color.fromARGB(255, 166, 231, 101),
        // centerTitle: true,
        // ignore: prefer_const_literals_to_create_immutables
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 75, 117, 32),
      body: (isLoading == false && result == false)
          ? Column(
              children: [
                SizedBox(
                  height: 275,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 90, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage("assets/images/app-logo.png"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Digi Farmer',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 32),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      height: height - 275 - 80,
                      width: size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(40))),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: count,
                        itemBuilder: (context, index) {
                          return questions[index];
                        },
                      )),
                ),
                Container(
                  color: Colors.white,
                  height: 80,
                ),
              ],
            )
          : (result == false)
              ? const CircularProgressIndicator()
              : Container(
                  height: height,
                  width: size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                          height: 250,
                          width: size.width,
                          color: const Color.fromARGB(255, 75, 117, 32),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                        'assets/images/app-logo.png',
                                      ),
                                      radius: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'Digi Farmer has calculated and here are the results!',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, color: Colors.white),
                                  )),
                                ],
                              ),
                              Text(
                                'Results',
                                style: GoogleFonts.poppins(
                                    fontSize: 36, color: Colors.white),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                          height: 300,
                          child: Image.asset(
                            getAsset(ans),
                            fit: BoxFit.fill,
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        getText(ans),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 26, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
    );
  }

  Future<int> getData() async {
    Random random = Random();
    int a1, a2, a3;
    if (pesticide_count == 0) {
      a1 = 1;
      a2 = 0;
      a3 = 0;
    } else if (pesticide_count == 1) {
      a1 = 0;
      a2 = 1;
      a3 = 0;
    } else {
      a1 = 0;
      a2 = 0;
      a3 = 1;
    }
    print(pesticide_week);
    final url = Uri.parse(
        'http://karanpatra203.pythonanywhere.com/predict?a=${random.nextInt(4097 - 150) + 150}&b=$type_of_crop&c=$soil_type&d=$pesticide_count&e=$pesticide_week&f=${random.nextInt(50)}&g=$a1&h=$a2&i=$a3&k=0&l=0&m=1');
    print(url);
    final headers = {"Content-type": "application/json"};
    final json =
        '{"a"=${random.nextInt(4097 - 150) + 150}&"b"=$type_of_crop&"c"=$soil_type&"d"=$pesticide_count&"e"=$pesticide_week&"f"=${random.nextInt(50)}&"g"=1&"h"=2&"i"=3&"k=1&"l"=2&"m"=3}';
    final response = await get(
      url,
    );
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    print(int.parse(response.body[1]));
    return int.parse(response.body[1]);
  }

  String getAsset(int ans) {
    if (ans == 0) {
      return "assets/plant_happy.png";
    } else {
      return "assets/plant_sad.png";
    }
  }

  String getText(int ans) {
    if (ans == 0) {
      return "Your crop is Healthy!!";
    } else if (ans == 1) {
      return "Your crop may be damaged";
    } else {
      return "Your crop is damaged due to overuse of pesticide";
    }
  }
}
