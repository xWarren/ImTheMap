import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'package:itm/controller/magalang_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/fade_animation.dart';
import 'mabalacat_gallery.dart';

class MagalangPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const MagalangPage({Key? key, required this.documentSnapshot})
      : super(key: key);

  //launch url
  _launchURL() async {
    var url = documentSnapshot['facebook'];
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //launch url
  _launchURL1() async {
    var url = documentSnapshot['location'];
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool placeImg = true;
    bool myMarkerThumb = true;
    bool isHorizontal = true;
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
        child: Column(
          children: [
            FadeAnimation(
                delay: 100,
                Axis: false,
                child: Container(
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    color: ColorPalette.container.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      FadeAnimation(
                          delay: 100,
                          Axis: false,
                          child: Container(
                            width: 160,
                            height: 120,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: myMarkerThumb != 'noImage'
                                      ? NetworkImage(documentSnapshot['image'])
                                      : const AssetImage(
                                      'assets/images/noImageAvailable.png')
                                  as ImageProvider,
                                  fit: BoxFit.cover,
                                )),
                          )),
                      const SizedBox(height: 5),
                      FadeAnimation(
                          delay: 500,
                          Axis: false,
                          child: AutoSizeText(
                            documentSnapshot["name"],
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorPalette.titleColor,
                            ),
                            maxFontSize: 20,
                            minFontSize: 15,
                            textAlign: TextAlign.justify,
                          )),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  'Details: ',
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  documentSnapshot['details'],
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.titleColor,
                                  ),
                                  textAlign: TextAlign.justify,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  'Price: ',
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  documentSnapshot['price'],
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  'Resort Time: ',
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  documentSnapshot['resorttime'],
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  'Contact Info: ',
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  documentSnapshot['contactinfo'],
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  'Google Reviews: ',
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  "${documentSnapshot['ratings'].toString()} / 5",
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                            SizedBox(width: 2),
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  'Feedback: ',
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeAnimation(
                              delay: 1300,
                              Axis: false,
                              child: Container(
                                width: 350,
                                height: 150,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            documentSnapshot['feedback1']),
                                        fit: BoxFit.fill)),
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeAnimation(
                              delay: 1300,
                              Axis: false,
                              child: Container(
                                width: 350,
                                height: 150,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            documentSnapshot['feedback2']),
                                        fit: BoxFit.fill)),
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeAnimation(
                              delay: 1300,
                              Axis: false,
                              child: Container(
                                width: 350,
                                height: 150,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            documentSnapshot['feedback3']),
                                        fit: BoxFit.fill)),
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeAnimation(
                              delay: 700,
                              Axis: false,
                              child: Text(
                                'LOOK THE BEAUTY OF RESORT',
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.titleColor),
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeAnimation(
                              delay: 1300,
                              Axis: false,
                              child: Container(
                                width: 160,
                                height: 120,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            documentSnapshot['image1']),
                                        fit: BoxFit.fill)),
                              )),
                          FadeAnimation(
                              delay: 1300,
                              Axis: false,
                              child: Container(
                                width: 160,
                                height: 120,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(documentSnapshot['image3']),
                                        fit: BoxFit.cover)),
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeAnimation(
                              delay: 1300,
                              Axis: isHorizontal,
                              child: Container(
                                width: 160,
                                height: 120,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            documentSnapshot['image5']),
                                        fit: BoxFit.fill)),
                              )),
                          FadeAnimation(
                              delay: 1300,
                              Axis: isHorizontal,
                              child: Container(
                                width: 160,
                                height: 120,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            documentSnapshot['image7']),
                                        fit: BoxFit.fill)),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeAnimation(
                              delay: 1500,
                              Axis: false,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorPalette.buttons,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MagalangGallery(
                                                    magalangimage:
                                                    documentSnapshot)));
                                  },
                                  child: Text('View more photos',
                                      style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: ColorPalette.backgroundcolor,
                                      )))),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: FadeAnimation(
                            delay: 1900,
                            Axis: false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Visit',
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.titleColor,
                                  ),
                                ),
                                const SizedBox(width: 5,height: 5),
                                GestureDetector(
                                  onTap: () => _launchURL(),
                                  child: Center(
                                      child: Image.asset(
                                          'assets/icons/facebook-icon.png')),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'for more information.',
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.titleColor,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: FadeAnimation(
                          delay: 2200,
                          Axis: false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Visit',
                                style: GoogleFonts.robotoMono(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5,height: 5),
                              GestureDetector(
                                onTap: () => _launchURL1(),
                                child: Center(
                                    child: Image.asset(
                                        'assets/icons/google-maps.png')),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'to know the location of resort',
                                style: GoogleFonts.robotoMono(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class AlerPop extends StatefulWidget {
  const AlerPop({Key? key}) : super(key: key);

  @override
  State<AlerPop> createState() => _AlerPopState();
}

class _AlerPopState extends State<AlerPop> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
