import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ColorPalettes/color.dart';
import '../utils/fade_animation.dart';

class MessagePage extends StatelessWidget {
  final DocumentSnapshot messageSnapshot;
  const MessagePage({Key? key, required this.messageSnapshot})
      : super(key: key);

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
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          color: ColorPalette.backgroundcolor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Column(
                children: [
                  FadeAnimation(
                      delay: 100,
                      Axis: false,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1,
                        clipBehavior: Clip.none,
                        decoration: BoxDecoration(
                          color: ColorPalette.container.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Email:',
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.titleColor,
                                  )),
                              subtitle: Text(
                                messageSnapshot['email'],
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w600,
                                  color: ColorPalette.titleColor,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Message: ',
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w600,
                                  color: ColorPalette.titleColor,
                                ),
                              ),
                              subtitle: Text(
                                messageSnapshot['message'],
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w600,
                                  color: ColorPalette.titleColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
