import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'package:itm/admin_panel/angeles_data.dart';
import 'package:itm/admin_panel/mabalacat_data.dart';
import 'package:itm/admin_panel/magalang_data.dart';
import 'package:itm/admin_panel/message_data.dart';
import 'package:itm/admin_panel/search_data.dart';
import 'package:itm/testing/helper.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final CollectionReference _angeles =
      FirebaseFirestore.instance.collection('angeles');
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;
    AuthenticateService authenticateService = AuthenticateService();
    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        backgroundColor: ColorPalette.backgroundcolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(authenticateService.emailAdmin.text,
            style: TextStyle(color: Colors.black),),
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
        ),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: GridView(
              shrinkWrap: false,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2),
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorPalette.buttons),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      )),
                  clipBehavior: Clip.none,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AngelesData()));
                  },
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Ionicons.add,
                            color: ColorPalette.titleColor, size: 70),
                        Text('Angeles',
                            style: GoogleFonts.openSans(
                                color: ColorPalette.titleColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorPalette.buttons),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      )),
                  clipBehavior: Clip.none,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MabalacatData()));
                  },
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Ionicons.add,
                            color: ColorPalette.titleColor, size: 70),
                        Text('Mabalacat',
                            style: GoogleFonts.openSans(
                                color: ColorPalette.titleColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorPalette.buttons),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      )),
                  clipBehavior: Clip.none,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MagalangData()));
                  },
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Ionicons.add,
                            color: ColorPalette.titleColor, size: 70),
                        Text('Magalang',
                            style: GoogleFonts.openSans(
                                color: ColorPalette.titleColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorPalette.buttons),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      )),
                  clipBehavior: Clip.none,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchData()));
                  },
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Ionicons.add,
                            color: ColorPalette.titleColor, size: 70),
                        Text('Search',
                            style: GoogleFonts.openSans(
                                color: ColorPalette.titleColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(ColorPalette.buttons),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      )
                  ),
                  clipBehavior: Clip.none,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessageData()));
                  },
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Ionicons.mail, color: ColorPalette.titleColor, size: 70),
                        Text('Message',style: GoogleFonts.openSans(color: ColorPalette.titleColor, fontSize: 15, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
