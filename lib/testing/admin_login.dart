import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itm/testing/helper.dart';

import '../ColorPalettes/color.dart';
import '../authenticator/process.dart';
import '../utils/fade_animation.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  AuthenticateService authenticateService = AuthenticateService();
  bool isHorizontal = false;
  bool isVertical = true;
  // login form
  final _keyForm = GlobalKey<FormState>();
  // firebase auth
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor,
      body: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeAnimation(
                    delay: 100,
                    Axis: isHorizontal,
                    child: SizedBox(
                      width: 250,
                      child: Image.asset(
                        'assets/login_vector.png',
                        fit: BoxFit.cover,
                      ),
                    )),
                //Hi!
                FadeAnimation(
                  delay: 200,
                  Axis: isHorizontal,
                  child: Text(
                    'Hello Admin!',
                    style: GoogleFonts.openSans(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                FadeAnimation(
                  delay: 300,
                  Axis: isVertical,
                  child: TextField(
                    controller: authenticateService.emailAdmin,
                    decoration: InputDecoration(
                        labelText: "E-mail",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    style: const TextStyle(color: ColorPalette.textColor),
                  ),
                ),
                const SizedBox(height: 15),
                FadeAnimation(
                  delay: 400,
                  Axis: isVertical,
                  child: TextField(
                    controller: authenticateService.passwordAdmin,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    style: const TextStyle(color: ColorPalette.textColor),
                  ),
                ),
                const SizedBox(height: 25),
                FadeAnimation(
                  delay: 500,
                  Axis: isHorizontal,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: ColorPalette.buttons,
                    child: MaterialButton(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        minWidth: 200,
                        onPressed: () {
                          if (authenticateService.emailAdmin != "" &&
                              authenticateService.passwordAdmin != "") {
                            authenticateService.loginAdmin(context);
                          }
                        },
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: ColorPalette.titleColor,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void login(String email, String password) async {
    if (_keyForm.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Process())),
              })
          .catchError((e) {
        Fluttertoast.showToast(
            msg: e!.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
      });
    }
  }
}
