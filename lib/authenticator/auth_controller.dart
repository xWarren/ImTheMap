import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itm/authenticator/process.dart';
import 'package:itm/controller/navigator.dart';
import 'package:flutter/material.dart';

import '../testing/loginone.dart';

class AuthController extends GetxController {
  //AuthController.instance
  static final AuthController instance = Get.find();
  //email, password and name
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if(user==null) {
      print("Login page");
      Get.offAll(()=>LoginPage());
    } else {
      Get.offAll(()=>Process());
    }
  }

  void register(String email, password) async {
    try{
     await  auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch(e) {
      Get.snackbar("About User", "User Message",
      snackPosition: SnackPosition.TOP,
      titleText: Text(
        "Account creation failed",
        style: GoogleFonts.merriweather(
          fontSize: 15
        ),
      ),
        messageText: Text(
          e.toString(),
          style: GoogleFonts.merriweather(
            fontSize: 15
          ),
        )
      );
    }
  }
  Future addUsersDetails(String name, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'email': email
    });
  }
  void login(String email, password) async {
    try{
      await  auth.signInWithEmailAndPassword(email: email, password: password);
    } catch(e) {
      Get.snackbar("About Login", "Login Message",
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            "Login failed",
            style: GoogleFonts.merriweather(
                fontSize: 15
            ),
          ),
          messageText: Text(
            e.toString(),
            style: GoogleFonts.merriweather(
                fontSize: 15
            ),
          )
      );
    }
  }
  void anonymous() async {
    try{
      await  auth.signInAnonymously();
      print("Signed in with temporary account.");
    } catch(e) {
      Get.snackbar("About Login", "Login Message",
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            "Login failed",
            style: GoogleFonts.merriweather(
                fontSize: 15
            ),
          ),
          messageText: Text(
            e.toString(),
            style: GoogleFonts.merriweather(
                fontSize: 15
            ),
          )
      );
    }
  }
  void loginAsAdmin(String email, password) async {
    try{
      await  auth.signInWithEmailAndPassword(email: 'admin@gmail.com', password: 'admin');
    } catch(e) {
      Get.snackbar("About Login", "Login Message",
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            "Login failed",
            style: GoogleFonts.merriweather(
                fontSize: 15
            ),
          ),
          messageText: Text(
            e.toString(),
            style: GoogleFonts.merriweather(
                fontSize: 15
            ),
          )
      );
    }
  }

  void logout() async {
    await auth.signOut();
  }
}

