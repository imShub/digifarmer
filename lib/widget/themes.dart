import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.lightGreen,
        fontFamily: "Montserrat",
        // fontFamily: GoogleFonts.poppins().fontFamily,
        // appBarTheme: AppBarTheme(
        //   color: Colors.white,
        //   elevation: 0.0,
        //   iconTheme: IconThemeData(color: Colors.black),
        //   titleTextStyle: TextStyle(color: Colors.black),
        // ),
      );

  static ThemeData darktheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
      );

  //Colors

  static Color creamColor = const Color(0xfff5f5f5);
  static Color darkBluishColor = const Color(0xff403b58);
}
