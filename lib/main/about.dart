import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ColorPalettes/color.dart';
import '../utils/fade_animation.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15),
            FadeAnimation(
                delay: 500,
                Axis: isHorizontal,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: AutoSizeText(
                    'ImTheMap: An Android Mobile App That Locates Nearby Resorts',
                    style: GoogleFonts.openSans(
                        color: ColorPalette.titleColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                    textAlign: TextAlign.justify,
                  ),
                )),
            FadeAnimation(
                delay: 500,
                Axis: isHorizontal,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: AutoSizeText(
                    'The Meaning and History of this Application',
                    style: GoogleFonts.openSans(
                        color: ColorPalette.titleColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                )),
            FadeAnimation(
                delay: 500,
                Axis: isHorizontal,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: AutoSizeText(
                    'The Philippines is rich in natural resources and in culture and is endowed, with what some environmentalists have specifically mentioned the world’s greatest biodiversity. Taking advantage of this biodiversity and with an area of 300,000 square kilometers and a population of approximately 100 million, the entire archipelago is dotted with numerous fun spots and resorts. Pampanga is one of the most densely populated provinces in the Philippines, is no exception. It is one of the country’s most prized regions as it is the host of a number of pleasurable attractions.',
                    style: GoogleFonts.openSans(
                        color: ColorPalette.titleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                )),
            SizedBox(height: 15),
            FadeAnimation(
                delay: 500,
                Axis: isHorizontal,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: AutoSizeText(
                    'Pampanga has quite a number of popular resorts, foremost of which is the postcard-worthy Aqua Planet Water Park. However, each district in the said province has its own summer place to boast of and special places to visit from beaches to swimming pools. The 1st District of Pampanga also has quite a number of popular resorts. This district is composed of the city of San Fernando and the towns of Magalang, Mabalacat and Angeles. Every municipality mentioned has different extraordinary resort attraction.',
                    style: GoogleFonts.openSans(
                        color: ColorPalette.titleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FadeAnimation(
                  delay: 500,
                  Axis: isHorizontal,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "assets/resorts_logo.png",
                        fit: BoxFit.cover,
                        width: 120,
                        height: 200,
                      ),
                    ),
                  ),
                ),
                FadeAnimation(
                  delay: 500,
                  Axis: isHorizontal,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "assets/b3.jpg",
                        fit: BoxFit.cover,
                        width: 180,
                        height: 190,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FadeAnimation(
                  delay: 500,
                  Axis: isHorizontal,
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "assets/b4.jpg",
                        fit: BoxFit.cover,
                        width: 180,
                        height: 190,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                FadeAnimation(
                    delay: 500,
                    Axis: isHorizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: AutoSizeText(
                        'In order to boost the tourism industry of the said district, the researchers conceptualized the idea of creating the “ImTheMap: An Android Mobile App That Locates Nearby Resort” mobile application which was intended to provide a trouble-free plan of seeking resorts for 1st District of Pampanga based on the user’s current position. This flexible search tool let the researchers browse easier than ever. It is fast as light in providing driving directions, and gives them the needed information, activities and amenities. This application can be used even without wireless fidelity – off-line service as they say. The point was, this application could seamlessly be connected and interacted with customers that made it a valuable tool for the modern business. So their next personalized get away is just one tap away.',
                        style: GoogleFonts.openSans(
                            color: ColorPalette.titleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    )),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                FadeAnimation(
                    delay: 500,
                    Axis: isHorizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: AutoSizeText(
                        'The researchers hope that with this proposed study, the tourism industry within District 1 of Pampanga will be given a much need boost for the betterment of its towns and populace as well as to future tourists.',
                        style: GoogleFonts.openSans(
                            color: ColorPalette.titleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
