import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:itm/ColorPalettes/color.dart';

import '../utils/fade_animation.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference contact =
        FirebaseFirestore.instance.collection('contact');
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    bool isHorizontal = false;
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
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: FadeAnimation(
                delay: 700,
                Axis: isHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: RichText(
                            text: TextSpan(children: [
                      TextSpan(
                          text: 'We are a responsive developer and admin',
                          style: GoogleFonts.openSans(
                              color: ColorPalette.titleColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w800)),
                    ]))),
                    const SizedBox(height: 5),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text:
                            'If you encounter an error or any questions about the application, Just fill out the form below.',
                        style: GoogleFonts.openSans(
                          color: ColorPalette.titleColor,
                          fontSize: 14,
                        ),
                        spellOut: true,
                      ),
                    ])),
                    TextFormField(
                      controller: nameController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please input name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Ionicons.person),
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please input email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Ionicons.mail_open),
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      maxLines: 10,
                      controller: messageController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please input message';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Ionicons.chatbox),
                          labelText: 'Message',
                          border: InputBorder.none),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPalette.buttons),
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Processing Data',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorPalette.titleColor)),
                              backgroundColor: ColorPalette.backgroundcolor,
                            ),
                          );
                          final String name = nameController.text;
                          final String email = emailController.text;
                          final String message = messageController.text;
                          await contact.add({
                            "name": name,
                            "email": email,
                            "message": message
                          });
                          nameController.text = '';
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Message Sent!',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorPalette.titleColor)),
                              backgroundColor: ColorPalette.backgroundcolor,
                            ),
                          );
                        }
                      },
                      child: Center(
                          child: Text(
                        'Submit',
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: ColorPalette.backgroundcolor,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
