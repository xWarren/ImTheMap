import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itm/admin_panel/admin_crud.dart';
import 'package:itm/authenticator/process.dart';
import 'package:itm/testing/loginone.dart';

class AuthenticateService {
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
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Center(
                child: CircularProgressIndicator(),
              ),
            );
          });
      await auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Process()),
            (route) => false);
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text("Error Message"),
                content: Text(e.toString()));
          });
    }
  }

  void loginAdmin(context) async {
    await FirebaseFirestore.instance
        .collection("admin")
        .doc("adminLogin")
        .snapshots()
        .forEach((element) {
      if (element.data()?['emailAdmin'] == emailAdmin.text &&
          element.data()?['passwordAdmin'] == passwordAdmin.text) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AdminPanel()),
            (route) => false);
      }
    }).catchError((e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text("Error Message"),
                content: Text(e.toString()));
          });
    });
  }

  void registerUser(context) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Center(
                child: CircularProgressIndicator(),
              ),
            );
          });
      await auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        firestore.collection("users").add({
          "name": name.text,
          "image": image,
          "email": email.text,
          "password": password.text,
          "uid": auth.currentUser!.uid
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Process()));
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text("Error Message"),
                content: Text(e.toString()));
          });
    }
  }

  void logoutUser(context) async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
  }

  void anonymous(context) async {
    try {
      await auth.signInAnonymously();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Process()),
          (route) => false);
    } catch (e) {
      Navigator.pop(context);
      Get.snackbar("About Login", "Login Message",
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            "Login failed",
            style: GoogleFonts.merriweather(fontSize: 15),
          ),
          messageText: Text(
            e.toString(),
            style: GoogleFonts.merriweather(fontSize: 15),
          ));
    }
  }
}
