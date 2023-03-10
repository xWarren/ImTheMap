import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'package:itm/controller/search_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final currentUser = FirebaseAuth.instance;

  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorPalette.container.withOpacity(0.7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Card(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search), hintText: 'Search Resort....'),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
            ),
            //search collection
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('search').orderBy('name', descending: false).snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(child: Text(''))
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot data = snapshot.data!.docs[index];
                            if (name.isEmpty) {
                              return Container(
                                padding: EdgeInsets.only(top: 16),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: data['name'] + " - " + data['default_choice'],
                                                style: GoogleFonts.openSans(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorPalette.titleColor
                                                ),
                                              ),
                                          ]
                                        )
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchView(
                                                          searchSnapshot: data)));
                                        },
                                        child: Icon(
                                          Icons.open_in_new,
                                          color: ColorPalette.buttons,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } if (data['name'].toString().toLowerCase().startsWith(name.toLowerCase())) {
                              return Container(
                                padding: EdgeInsets.only(top: 16),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: data['name'] + " - " + data['default_choice'],
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: ColorPalette.titleColor
                                                  ),
                                                ),
                                              ]
                                          )
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchView(
                                                          searchSnapshot: data)));
                                        },
                                        child: Icon(
                                          Icons.open_in_new,
                                          color: ColorPalette.buttons,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                }),
          ],
        ),
      ),
    );
  }
}
