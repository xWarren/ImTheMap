// ignore_for_file: library_private_types_in_public_api, body_might_complete_normally_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'package:itm/authenticator/process.dart';
import 'package:itm/testing/admin_login.dart';
import 'package:itm/testing/forgot_password.dart';
import 'package:itm/testing/registerone.dart';

import '../utils/fade_animation.dart';
import 'helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  // login form
  final _keyForm = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase auth
  final _auth = FirebaseAuth.instance;

  AuthenticateService authenticateService = AuthenticateService();
  int emailLength = 0;
  int passwordLength = 0;
  bool toggled = true;
  bool isHorizontal = false;
  bool isVertical = true;
  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = FadeAnimation(
      delay: 400,
      Axis: isVertical,
      child: TextFormField(
        onChanged: (text) {
          setState(() {
            emailLength = text.length;
          });
        },
        autofocus: false,
        controller: emailController,
        style: const TextStyle(color: ColorPalette.textColor),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your Email");
          }
          // register expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[gmail]+[.]+[c-o-m]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            FontAwesomeIcons.solidAddressCard,
            color: emailLength < 5 ? Colors.grey : Colors.blue,
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          labelText: "Email",
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: emailLength < 5 ? Colors.grey : Colors.blue)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: emailLength < 5 ? Colors.grey : Colors.blue)),
        ),
      ),
    );

    //password field
    final passwordField = FadeAnimation(
      delay: 500,
      Axis: isVertical,
      child: TextFormField(
        autofocus: false,
        controller: passwordController,
        onChanged: (text) {
          setState(() {
            passwordLength = text.length;
          });
        },
        obscureText: _obscureText,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Please enter your password");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter valid password(Min. 6 Character)");
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(FontAwesomeIcons.lock,
              color: passwordLength < 3 ? Colors.grey : Colors.blue),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          labelText: "Password",
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: passwordLength < 3 ? Colors.grey : Colors.blue)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: passwordLength < 3 ? Colors.grey : Colors.blue)),
        ),
      ),
    );

    final loginButton = FadeAnimation(
      delay: 700,
      Axis: isHorizontal,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: ColorPalette.buttons,
        child: MaterialButton(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            minWidth: 200,
            onPressed: () {
              login(emailController.text, passwordController.text);
            },
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: ColorPalette.backgroundcolor,
                  fontWeight: FontWeight.w900),
            )),
      ),
    );
    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: Form(
              key: _keyForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(
                    delay: 100,
                    Axis: isHorizontal,
                    child: SizedBox(
                      width: 250,
                      child: Image.asset(
                        'assets/login_vector.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  //Hi!
                  FadeAnimation(
                    delay: 200,
                    Axis: isHorizontal,
                    child: Text(
                      'Hi!',
                      style: GoogleFonts.openSans(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.titleColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeAnimation(
                    delay: 300,
                    Axis: isHorizontal,
                    child: Text(
                      'Welcome back',
                      style: GoogleFonts.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.titleColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  emailField,
                  const SizedBox(height: 20),
                  passwordField,
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeAnimation(
                          delay: 600,
                          Axis: isHorizontal,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: ColorPalette.buttons),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  loginButton,
                  const SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FadeAnimation(
                          delay: 800,
                          Axis: isHorizontal,
                          child: Text(
                            "Don't have an account?",
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.titleColor,
                            ),
                          ),
                        ),
                        FadeAnimation(
                          delay: 900,
                          Axis: isHorizontal,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));
                            },
                            child: Text(
                              "Register",
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: ColorPalette.buttons),
                            ),
                          ),
                        ),
                      ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeAnimation(
                        delay: 1000,
                        Axis: isHorizontal,
                        child: TextButton(
                            onPressed: () {
                              authenticateService.anonymous(context);
                            },
                            child: Text(
                              "Login as Guest",
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: ColorPalette.buttons),
                            )),
                      ),
                    ],
                  )
                ],
              ),
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
