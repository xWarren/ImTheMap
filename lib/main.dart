import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'package:itm/authenticator/process.dart';
import 'package:itm/testing/admin_login.dart';
import 'package:itm/testing/loginone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

final auth = FirebaseAuth.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Im The Map',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          splash: Image.asset('assets/resorts_logo.png'),
          duration: 3000,
          splashIconSize: 300,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: ColorPalette.backgroundcolor,
          nextScreen: const AdminLogin(),
        ));
  }
}
