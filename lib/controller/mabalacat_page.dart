import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'package:itm/controller/start_rating.dart';
import 'package:url_launcher/url_launcher.dart';

import '../testing/user_class.dart';
import '../utils/fade_animation.dart';
import 'mabalacat_gallery.dart';
import 'navigator.dart';

class MabalacatPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const MabalacatPage({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  State<MabalacatPage> createState() => _MabalacatPageState();
}

class _MabalacatPageState extends State<MabalacatPage> {
  bool myMarkerThumb = true;
  bool isHorizontal = true;
  final currentUser = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserClass loggedInUser = UserClass();
  final TextEditingController messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final CollectionReference mabalacat =
      FirebaseFirestore.instance.collection('mabalacat');
  double _rating = 0;
  //launch url
  _launchURL() async {
    var url = widget.documentSnapshot['facebook'];

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //launch url
  _launchURL1() async {
    var url = widget.documentSnapshot['location'];
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //update
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null &&
        documentSnapshot.exists &&
        documentSnapshot.data() != null) {
      messageController.text = documentSnapshot['message'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tell us about your experienced here at ${widget.documentSnapshot["name"]}',
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: ColorPalette.titleColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          RatingBar.builder(
                            initialRating: _rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: 50,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                                if (_rating == 5) {
                                  print('User chose 5 stars!');
                                }
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              maxLines: 5,
                              controller: messageController,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please input message';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Ionicons.chatbox,
                                    color: Colors.grey,
                                  ),
                                  labelText: 'Message',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: Text('Processing Data',
                                        style: GoogleFonts.openSans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: ColorPalette.titleColor)),
                                    backgroundColor:
                                        ColorPalette.backgroundcolor,
                                  ),
                                );

                                final String message = messageController.text;
                                final double ratings = _rating;
                                await mabalacat
                                    .doc(documentSnapshot!.id)
                                    .update({
                                  'myArray': FieldValue.arrayUnion([message]),
                                  'RatingStar':
                                      FieldValue.arrayUnion([ratings]),
                                });
                                messageController.text = '';
                                // ignore: use_build_context_synchronously
                                Get.to(const MainPages());
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: Text("Thanks",
                                        style: GoogleFonts.openSans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: ColorPalette.titleColor)),
                                    backgroundColor:
                                        ColorPalette.backgroundcolor,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorPalette.buttons,
                            ),
                            child: Center(
                                child: Text(
                              'Submit',
                              style: GoogleFonts.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: ColorPalette.backgroundcolor,
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
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
                                      ? NetworkImage(
                                          widget.documentSnapshot['image'])
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
                            widget.documentSnapshot["name"],
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
                                  widget.documentSnapshot['details'],
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
                                  'Address: ',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeAnimation(
                                delay: 500,
                                Axis: false,
                                child: Text(
                                  widget.documentSnapshot['address'],
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
                                textAlign: TextAlign.justify,
                              ),
                            ),
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
                                  widget.documentSnapshot['price'],
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
                                  widget.documentSnapshot['resorttime'],
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
                                  widget.documentSnapshot['contactinfo'],
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.titleColor,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            FadeAnimation(
                                delay: 700,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FadeAnimation(
                                  delay: 800,
                                  Axis: false,
                                  child: widget
                                          .documentSnapshot['myArray'].isEmpty
                                      ? const Center(
                                          child: Text('No reviews yet'))
                                      : ListView.builder(
                                          itemCount: widget
                                              .documentSnapshot['myArray']
                                              .length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Card(
                                                color: ColorPalette
                                                    .backgroundcolor,
                                                elevation: 5,
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 20.0,
                                                      backgroundImage:
                                                          NetworkImage(loggedInUser
                                                                      .uid !=
                                                                  null
                                                              ? loggedInUser
                                                                  .image
                                                              : loggedInUser
                                                                  .guest_image),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(loggedInUser
                                                                              .firstName !=
                                                                          null &&
                                                                      loggedInUser
                                                                              .lastName !=
                                                                          null
                                                                  ? "${loggedInUser.firstName} ${loggedInUser.lastName}"
                                                                  : 'Anonymous'),
                                                              _buildRating(
                                                                  index),
                                                              Text(
                                                                widget
                                                                        .documentSnapshot[
                                                                            'myArray']
                                                                        .isEmpty
                                                                    ? const Center(
                                                                        child: Text(
                                                                            'No reviews yet'))
                                                                    : widget.documentSnapshot[
                                                                            'myArray']
                                                                        [index],
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: ColorPalette
                                                                      .titleColor,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(thickness: 2),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
                                            widget.documentSnapshot['image1']),
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
                                        image: NetworkImage(
                                            widget.documentSnapshot['image3']),
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
                                            widget.documentSnapshot['image5']),
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
                                            widget.documentSnapshot['image7']),
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
                                                MabalacatGallery(
                                                    mabalacatimage: widget
                                                        .documentSnapshot)));
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
                                const SizedBox(width: 5, height: 5),
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
                              const SizedBox(width: 5, height: 5),
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
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: FadeAnimation(
                          delay: 2300,
                          Axis: false,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorPalette.buttons),
                            onPressed: () async {
                              await _update(widget.documentSnapshot);
                            },
                            child: Center(
                                child: Text(
                              'Feedback',
                              style: GoogleFonts.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: ColorPalette.backgroundcolor,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Container _buildRating(int index) {
    double rating =
        double.parse(widget.documentSnapshot['RatingStar'][index].toString());
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: StarRating(
        rating: rating,
        onRatingChanged: (rating) => rating = rating,
        color: Colors.amber,
      ),
    );
  }
}
