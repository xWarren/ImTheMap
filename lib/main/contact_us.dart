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
    final CollectionReference _contact =
        FirebaseFirestore.instance.collection('contact');
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _messageController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

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
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
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
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'We are a responsive developer and admin',
                                style: GoogleFonts.openSans(
                                  color: ColorPalette.titleColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800
                                )
                              ),
                            ]
                          ))
                    ),
                    SizedBox(height: 5),
                    RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'If you encounter an error or any questions about the application, Just fill out the form below.',
                                  style: GoogleFonts.openSans(
                                    color: ColorPalette.titleColor,
                                    fontSize: 14,
                                  ),
                                spellOut: true,
                              ),
                            ]
                        )),
                    TextFormField(
                      controller: _nameController,
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
                      controller: _emailController,
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
                      controller: _messageController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please input message';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Ionicons.chatbox),
                          labelText: 'Message', border: InputBorder.none),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPalette.buttons),
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data',
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: ColorPalette.titleColor)),
                              backgroundColor: ColorPalette.backgroundcolor,
                            ),
                          );
                          final String name = _nameController.text;
                          final String email = _emailController.text;
                          final String message = _messageController.text;
                          if (name != null) {
                            await _contact.add({
                              "name": name,
                              "email": email,
                              "message": message
                            });
                            _nameController.text = '';
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Message Sent!',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: ColorPalette.titleColor)),
                                backgroundColor: ColorPalette.backgroundcolor,
                              ),
                            );
                          }
                        }
                      },
                      child: Center(child: Text('Submit',
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: ColorPalette.backgroundcolor,
                        ),)),
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
