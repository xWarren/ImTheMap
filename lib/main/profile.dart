import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ColorPalettes/color.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  //launch url
  _launchURL() async {
    const url = 'https://www.facebook.com/ryan.naguit.1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL1() async {
    const url = 'https://www.facebook.com/nicodungca10gmailcom';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL2() async {
    const url = 'https://www.facebook.com/ca.1693';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL3() async {
    const url = 'https://www.facebook.com/kristine.dayrit.77';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL4() async {
    const url = 'https://www.facebook.com/panjuk.tyamuts';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  //alert profile
  void showAlert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        backgroundColor: ColorPalette.backgroundcolor,
        text: 'Graphic Designer',
        textColor: ColorPalette.textColor,
        title: 'Mark Ryan Naguit',
        titleColor: ColorPalette.titleColor,
        customAsset: "assets/resorts_logo.png",
        width: 30,
        barrierColor: ColorPalette.backgroundcolor,
        barrierDismissible: false,
        confirmBtnTextStyle: GoogleFonts.openSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: ColorPalette.backgroundcolor,
        ),
        confirmBtnColor: ColorPalette.buttons,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _launchURL(),
              child: Center(
                  child: Image.asset(
                      'assets/icons/facebook-icon.png'
                  )
              ),
            )
          ],
        )
    );
  }
  void showAlert1() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        backgroundColor: ColorPalette.backgroundcolor,
        text: 'Programmer',
        textColor: ColorPalette.textColor,
        title: 'Nico Dungca',
        titleColor: ColorPalette.titleColor,
        customAsset: "assets/resorts_logo.png",
        width: 30,
        barrierColor: ColorPalette.backgroundcolor,
        barrierDismissible: false,
        confirmBtnTextStyle: GoogleFonts.openSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: ColorPalette.backgroundcolor,
        ),
        confirmBtnColor: ColorPalette.buttons,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _launchURL1(),
              child: Center(
                  child: Image.asset(
                      'assets/icons/facebook-icon.png'
                  )
              ),
            )
          ],
        )

    );
  }
  void showAlert2() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        backgroundColor: ColorPalette.backgroundcolor,
        text: 'Researcher',
        textColor: ColorPalette.textColor,
        title: 'Carol De Jesus',
        titleColor: ColorPalette.titleColor,
        customAsset: "assets/resorts_logo.png",
        width: 30,
        barrierColor: ColorPalette.backgroundcolor,
        barrierDismissible: false,
        confirmBtnTextStyle: GoogleFonts.openSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: ColorPalette.backgroundcolor,
        ),
        confirmBtnColor: ColorPalette.buttons,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _launchURL2(),
              child: Center(
                  child: Image.asset(
                      'assets/icons/facebook-icon.png'
                  )
              ),
            )
          ],
        )
    );
  }
  void showAlert3() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        backgroundColor: ColorPalette.backgroundcolor,
        text: 'Photographer',
        textColor: ColorPalette.textColor,
        title: 'Kristine Dayrit',
        titleColor: ColorPalette.titleColor,
        customAsset: "assets/resorts_logo.png",
        width: 30,
        barrierColor: ColorPalette.backgroundcolor,
        barrierDismissible: false,
        confirmBtnTextStyle: GoogleFonts.openSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: ColorPalette.backgroundcolor,
        ),
        confirmBtnColor: ColorPalette.buttons,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _launchURL3(),
              child: Center(
                  child: Image.asset(
                      'assets/icons/facebook-icon.png'
                  )
              ),
            )
          ],
        )
    );
  }
  void showAlert4() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        backgroundColor: ColorPalette.backgroundcolor,
        text: 'Researcher',
        textColor: ColorPalette.textColor,
        title: 'John Michael Ramos',
        titleColor: ColorPalette.titleColor,
        customAsset: "assets/resorts_logo.png",
        width: 30,
        barrierColor: ColorPalette.backgroundcolor,
        barrierDismissible: false,
        confirmBtnTextStyle: GoogleFonts.openSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: ColorPalette.backgroundcolor,
        ),
        confirmBtnColor: ColorPalette.buttons,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _launchURL4(),
              child: Center(
                  child: Image.asset(
                      'assets/icons/facebook-icon.png'
                  )
              ),
            )
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.backgroundcolor,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              AutoSizeText(
                'OUR DEVELOPERS',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: ColorPalette.titleColor,

                ),
              ),
              AutoSizeText(
                'Meet the team',
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.textColor,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showAlert();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ColorPalette.backgroundcolor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          'https://i.ibb.co/165W9D7/mark.jpg',
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showAlert1();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ColorPalette.backgroundcolor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          'https://i.ibb.co/c2pJ54s/nico.jpg',
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showAlert2();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ColorPalette.backgroundcolor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          'https://i.ibb.co/9t5yfCz/carol.jpg',
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showAlert3();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ColorPalette.backgroundcolor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          'https://i.ibb.co/qFSwSXD/kristine.jpg',
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showAlert4();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ColorPalette.backgroundcolor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.network(
                          'https://i.ibb.co/9tX9rH7/5.jpg',
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        )
    );
  }
}
