import 'package:demo_hackit/views/root_app.dart';
import 'package:demo_hackit/views/welcome_page.dart';
import 'package:flutter/material.dart';

import 'util/routes.dart';
import 'views/login_page.dart';
import 'widget/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: WelcomePage(),
      initialRoute: MyRoutes.welcomeRoute,
      routes: {
        // "/": (context) => WelcomePage(),
        MyRoutes.welcomeRoute: (context) => WelcomePage(),
        // MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        // MyRoutes.cartRoute: (context) => CartPage(),
      },
    );
  }
}
