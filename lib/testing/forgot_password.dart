import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itm/ColorPalettes/color.dart';

import '../utils/fade_animation.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  bool isHorizontal = false;
  bool isVertical = true;
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: ColorPalette.backgroundcolor,
              content: Text(
                'Password reset link has been sent! Check the email in Spam.',
                style: GoogleFonts.prompt(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade500),
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: ColorPalette.backgroundcolor,
              content: Text(
                e.message.toString(),
                style: GoogleFonts.prompt(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade500),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        FadeAnimation(
        delay: 100,
        Axis: isHorizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Enter your email address and we will send you a link to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ),
          SizedBox(height: 15),
          //email field
      FadeAnimation(
        delay: 200,
        Axis: isVertical,
         child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextFormField(
              autofocus: false,
              controller: emailController,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
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
                prefixIcon: const Icon(FontAwesomeIcons.solidAddressCard),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                labelText: "Email",
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
      ),
          SizedBox(height: 25),
      FadeAnimation(
        delay: 300,
        Axis: isHorizontal,
         child: Material(
             elevation: 5,
             borderRadius: BorderRadius.circular(30),
             color: ColorPalette.buttons,
           child: MaterialButton(
             padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
             minWidth: 200,
              onPressed: resetPassword,
              child: Text(
                'Reset Password',
                style: GoogleFonts.prompt(
                    fontSize: 20,
                    color: ColorPalette.backgroundcolor,
                    fontWeight: FontWeight.bold),
                ),
              ),
            ),
         ),
        ],
      ),
    );
  }
}
