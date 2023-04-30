import 'package:digi_farmer/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'util/routes.dart';
import 'views/login_page.dart';
import 'widget/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const WelcomePage(),
      initialRoute: MyRoutes.welcomeRoute,
      routes: {
        // "/": (context) => WelcomePage(),
        MyRoutes.welcomeRoute: (context) => const WelcomePage(),
        // MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        // MyRoutes.cartRoute: (context) => CartPage(),
      },
    );
  }
}
