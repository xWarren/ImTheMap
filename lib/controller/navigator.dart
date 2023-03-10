import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'package:itm/main/home.dart';
import 'package:itm/main/profile.dart';
import 'package:itm/main/search.dart';

class MainPages extends StatefulWidget {
  MainPages({Key? key}) : super(key: key);

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  List pages = [
    HomePage(),
    SearchPage(),
    Profile(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.buttons,
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: ColorPalette.buttons,
        backgroundColor: ColorPalette.backgroundcolor,
        items: <Widget>[
          Icon(Ionicons.home, size: 25),
          Icon(Ionicons.search, size: 25),
          Icon(Icons.people, size: 25),
        ],
        onTap: onTap,
      ),
    );
  }
}
