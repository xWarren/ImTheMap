import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itm/admin_panel/admin_crud.dart';
import 'package:itm/authenticator/process.dart';
import 'package:itm/testing/admin_login.dart';
import 'package:itm/testing/loginone.dart';

import '../main.dart';

class AuthenticateService{
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController emailAdmin = TextEditingController();
  TextEditingController passwordAdmin = TextEditingController();
  TextEditingController nameAdmin = TextEditingController();
  TextEditingController name = TextEditingController();
  String image = "https://i.ibb.co/K0kX5hD/user-icon.jpg";
  final firestore = FirebaseFirestore.instance;
  void loginUser(context) async {
    try {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      await auth.signInWithEmailAndPassword(email: email.text, password: password.text).then((value) {
        print("User is Logged in");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Process()),
                (route) => false);
      });
    } catch(e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
            title: Text("Error Message"),
            content: Text(e.toString())
        );
      });
    }
  }

  void loginAdmin(context) async {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
    await FirebaseFirestore.instance
        .collection("admin")
        .doc("adminLogin")
        .snapshots()
        .forEach((element) {
      if(element.data()?['emailAdmin'] == emailAdmin.text && element.data()?['passwordAdmin'] == passwordAdmin.text) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>AdminPanel()), (route) => false);
      }
    }).catchError((e){
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
            title: Text("Error Message"),
            content: Text(e.toString())
        );
      });
    });
  }

  void registerUser(context) async {
    try {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      await auth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value){
        print("User is Registered");
        firestore.collection("users").add({
          "name":name.text,
          "image": image,
          "email":email.text,
          "password":password.text,
          "uid":auth.currentUser!.uid
        });
        Navigator.push(context, MaterialPageRoute(builder: (c)=>Process()));
      });
    } catch(e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
            title: Text("Error Message"),
            content: Text(e.toString())
        );
      });
    }
  }

  void logoutUser(context) async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  void anonymous(context) async {
    try {
      await auth.signInAnonymously();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Process()), (route) => false);
    } catch (e) {
      Navigator.pop(context);
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
}