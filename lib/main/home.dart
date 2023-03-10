import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'package:itm/controller/angeles_page.dart';
import 'package:itm/main/about.dart';
import 'package:itm/main/contact_us.dart';
import 'package:itm/testing/helper.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import '../controller/mabalacat_page.dart';
import '../controller/magalang_page.dart';
import '../testing/user_class.dart';
import '../utils/fade_animation.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool toggled = true;
  bool isHorizontal = false;
  final maxLines = 1;
  AuthenticateService authenticateService = AuthenticateService();
  final currentUser = FirebaseAuth.instance;
  var angelesData =
      FirebaseFirestore.instance.collection("angeles").doc("uid").get();
  final Query _angeles = FirebaseFirestore.instance
      .collection('angeles')
      .orderBy('name', descending: false);
  final Query _mabalacat = FirebaseFirestore.instance
      .collection('mabalacat')
      .orderBy('name', descending: false);
  final Query _link = FirebaseFirestore.instance
      .collection('link');
  final Query _magalang = FirebaseFirestore.instance
      .collection('magalang')
      .orderBy('name', descending: false);
  bool myMarkerThumb = true;
  bool _isLoading = true;
  User? user = FirebaseAuth.instance.currentUser;
  UserClass loggedInUser = UserClass();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 1. Using Timer
    Timer(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
// 2. Future.delayed
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserClass.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: ColorPalette.backgroundcolor,
      drawer: Drawer(
        backgroundColor: ColorPalette.backgroundcolor,
        child: Column(
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName:Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                       loggedInUser.firstName != null && loggedInUser.lastName !=null
                           ? "${loggedInUser.firstName} ${loggedInUser.lastName}"
                           : 'Guest'
                    ),
                  ),
                  accountEmail: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      loggedInUser.email != null
                          ? "${loggedInUser.email}"
                          : ""
                    ),
                  ),
                  currentAccountPicture: Padding(
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      radius: 10.0,
                      backgroundImage: NetworkImage(
                          loggedInUser.uid != null
                              ? "${loggedInUser.image}"
                              : "${loggedInUser.guest_image}"
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                ListTile(
                    title: Text('About',
                        style: GoogleFonts.robotoMono(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutApp()));
                    },
                    leading: Icon(Ionicons.information_circle)),
                SizedBox(height: 20),
                ListTile(
                    title: Text('Contact us',
                        style: GoogleFonts.robotoMono(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ContactUs()));
                    },
                    leading: Icon(Ionicons.call)),

                StreamBuilder(
                    stream: _link.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return   ListTile(
                                  title: Text('Rate the app',
                                      style: GoogleFonts.robotoMono(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  onTap: () async {
                                    var url = documentSnapshot['urllink'];
                                    if (await canLaunch(url)) {
                                    await launch(url);
                                    } else {
                                    throw 'Could not launch $url';
                                    }
                                  },
                                  leading: Icon(Ionicons.star));
                            });
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                SizedBox(height: 25),
                ListTile(
                    title: Text('Log out',
                        style: GoogleFonts.robotoMono(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      AuthenticateService authenticateService =
                          AuthenticateService();
                      authenticateService.logoutUser(context);
                    },
                    leading: Icon(Ionicons.log_out_outline)),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 30),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: FadeAnimation(
                  delay: 100,
                  Axis: isHorizontal,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'We have the best resorts in Pampanga',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: ColorPalette.titleColor),
                    ),
                  ))),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeAnimation(
                delay: 900,
                Axis: isHorizontal,
                child: Text(
                  'Pampanga has quite a number of popular resorts, foremost of which is the postcard-worthy Aqua Planet Water Park. However, each district in the said province has its own summer place to boast of and special places to visit from beaches to swimming pools. The 1st District of Pampanga also has quite a number of popular resorts. This district is composed of the city of San Fernando and the towns of Magalang, Mabalacat and Angeles. Every municipality mentioned has different extraordinary resort attraction. ',
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: ColorPalette.textColor),
                  textAlign: TextAlign.justify,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeAnimation(
                    delay: 1500,
                    Axis: isHorizontal,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.buttons),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TextPampanga()));
                        },
                        child: Text(
                          'About Pampanga',
                          style: GoogleFonts.inter(
                              color: ColorPalette.backgroundcolor,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ))),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
              child: _isLoading
                  ? Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                    )
                  : Text(
                      'Angeles',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: ColorPalette.titleColor,
                      ),
                    )),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  child: StreamBuilder(
                      stream: _angeles.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (_isLoading) {
                          return Row(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Skeleton(
                                      height: 180,
                                      width: 120,
                                    ),
                                    SizedBox(width: 2),
                                    Skeleton(
                                      height: 180,
                                      width: 120,
                                    ),
                                    SizedBox(width: 2),
                                    Skeleton(
                                      height: 180,
                                      width: 120,
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ListView.builder(
                              itemCount: streamSnapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              clipBehavior: Clip.none,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AngelesPage(
                                                documentSnapshot:
                                                    documentSnapshot)));
                                  },
                                  child: Container(
                                    width: 160,
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.only(left: 15),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: ColorPalette.buttons.withOpacity(0.3), width: 0.8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                        color: Colors.black.withOpacity(0.3),
                                        image: DecorationImage(
                                          image: documentSnapshot['image'] != null
                                              ? NetworkImage(
                                                  documentSnapshot['image'])
                                              : AssetImage(
                                                      'assets/images/noImageAvailable.png')
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                );
                              });
                        }
                      }),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
              child: _isLoading
                  ? Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                    )
                  : Text(
                      'Mabalacat',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: ColorPalette.titleColor,
                      ),
                    )),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  child: StreamBuilder(
                      stream: _mabalacat.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (_isLoading) {
                          return Row(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Skeleton(
                                      height: 180,
                                      width: 120,
                                    ),
                                    SizedBox(width: 2),
                                    Skeleton(
                                      height: 180,
                                      width: 120,
                                    ),
                                    SizedBox(width: 2),
                                    Skeleton(
                                      height: 180,
                                      width: 120,
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ListView.builder(
                              itemCount: streamSnapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              clipBehavior: Clip.none,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MabalacatPage(
                                                documentSnapshot:
                                                    documentSnapshot)));
                                  },
                                  child: Container(
                                    width: 160,
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.only(left: 15),
                                    decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: ColorPalette.buttons.withOpacity(0.3), width: 0.8),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        color: Colors.black.withOpacity(0.3),
                                        image: DecorationImage(
                                          image: myMarkerThumb != 'noImage'
                                              ? NetworkImage(
                                                  documentSnapshot['image'])
                                              : AssetImage(
                                                      'assets/images/noImageAvailable.png')
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                );
                              });
                        }
                      }),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
              child: _isLoading
                  ? Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                    )
                  : Text(
                      'Magalang',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: ColorPalette.titleColor,
                      ),
                    )),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  child: StreamBuilder(
                      stream: _magalang.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (_isLoading) {
                          return Row(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Skeleton(
                                      height: 180,
                                      width: 120,
                                    ),
                                    SizedBox(width: 2),
                                    Skeleton(
                                      height: 180,
                                      width: 120,
                                    ),
                                    SizedBox(width: 2),
                                    Skeleton(
                                      height: 180,
                                      width: 120,
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ListView.builder(
                              itemCount: streamSnapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              clipBehavior: Clip.none,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MagalangPage(
                                                documentSnapshot:
                                                    documentSnapshot)));
                                  },
                                  child: Container(
                                    width: 160,
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.only(left: 15),
                                    decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: ColorPalette.buttons.withOpacity(0.3), width: 0.8),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        color: Colors.black.withOpacity(0.3),
                                        image: DecorationImage(
                                          image: myMarkerThumb != 'noImage'
                                              ? NetworkImage(
                                                  documentSnapshot['image'])
                                              : AssetImage(
                                                      'assets/images/noImageAvailable.png')
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                );
                              });
                        }
                      }),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}

class TextPampanga extends StatefulWidget {
  const TextPampanga({Key? key}) : super(key: key);

  @override
  State<TextPampanga> createState() => _TextPampangaState();
}

class _TextPampangaState extends State<TextPampanga> {
  bool isHorizontal = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
          decoration: BoxDecoration(
            color: ColorPalette.container.withOpacity(0.7),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              FadeAnimation(
                  delay: 100,
                  Axis: false,
                  child: Container(
                    width: 300,
                    height: 220,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage('assets/pampanga.jpg'),
                          fit: BoxFit.cover,
                        )),
                  )),
              SizedBox(height: 15),
              FadeAnimation(
                  delay: 500,
                  Axis: isHorizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: AutoSizeText(
                      ' Pampanga, officially the Province of Pampanga (Kapampangan: Lalawigan ning Pampanga; Tagalog: Lalawigan ng Pampanga), is a province in the Central Luzon region of the Philippines. Lying on the northern shore of Manila Bay, Pampanga is bordered by Tarlac to the north, Nueva Ecija to the northeast, Bulacan to the east, the Manila Bay to the central-south, Bataan to the southwest and Zambales to the west. Its capital is the City of San Fernando. Angeles City is the largest LGU but while geographically within Pampanga, it is classified as a first-class, highly urbanized city and has been governed independently of the province since it received its charter in 1964.',
                      style: GoogleFonts.openSans(
                        color: ColorPalette.titleColor,
                        fontWeight: FontWeight.w700,
                      ),
                      maxFontSize: 15,
                      minFontSize: 13,
                      textAlign: TextAlign.justify,
                    ),
                  )),
              FadeAnimation(
                  delay: 500,
                  Axis: false,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: AutoSizeText(
                      ' The name La Pampanga was given by the Spaniards, who encountered natives living along the banks (pampáng) of the Pampanga River. Its creation in 1571 makes it the first Spanish province on Luzon Island (Cebu in Visayas is older as it was founded by the Spaniards in 1565). The town of Villa de Bacolor in the province briefly served as the Spanish colonial capital when Great Britain invaded Manila as part of the Seven Years'
                      'War. At the eve of the Philippine Revolution of 1896, Pampanga was one of eight provinces placed under martial law for rebellion against the Spanish Empire; it is thus represented on the Philippine national flag as one of the eight rays of the sun.Pampanga is served by Clark International Airport (formerly Diosdado Macapagal International Airport), which is in Clark Freeport Zone, some 16 kilometres (9.9 mi) north of the provincial capital. The province is home to two Philippine Air Force airbases: Basa Air Base in Floridablanca and the former United States Clark Air Base in Angeles. Due to its growing population and developments, the Clark Global City is now developed and is located in Clark Freeport Zone. In 2015, the province had 2,198,110 inhabitants, while it had 1,079,532 registered voters.',
                      style: GoogleFonts.openSans(
                        color: ColorPalette.titleColor,
                        fontWeight: FontWeight.w700,
                      ),
                      maxFontSize: 15,
                      minFontSize: 13,
                      textAlign: TextAlign.justify,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
