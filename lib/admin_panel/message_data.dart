import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ColorPalettes/color.dart';
import '../controller/message_page.dart';

class MessageData extends StatefulWidget {
  const MessageData({Key? key}) : super(key: key);

  @override
  State<MessageData> createState() => _MessageDataState();
}

class _MessageDataState extends State<MessageData> {
  @override
  final CollectionReference _contact =
  FirebaseFirestore.instance.collection('contact');

  //delete
  Future<void> _delete(String productId) async {
    await _contact.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted a data')));
  }

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
      body: Container(
        color: ColorPalette.backgroundcolor.withOpacity(0.7),
        child: StreamBuilder(
            stream: _contact.orderBy('name', descending: false).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1,
                  width: MediaQuery.of(context).size.width / 1,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    color: ColorPalette.container.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: 100,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorPalette.backgroundcolor
                                        .withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset:
                                    Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  documentSnapshot['name'],
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  IconButton(
                                  icon: const Icon(Icons.check),
                                    color: ColorPalette.buttons,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MessagePage(messageSnapshot: documentSnapshot)));
                                    },
                                  ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: ColorPalette.buttons,
                                        onPressed: () =>
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  AlertDialog(
                                                    title: new Text('Are you sure?'),
                                                    content: new Text(
                                                        'Do you want to delete this message?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(context)
                                                                .pop(false),
                                                        child: new Text('No'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          _delete(
                                                              documentSnapshot.id);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: new Text('Yes'),
                                                      ),
                                                    ],
                                                  ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return CircularProgressIndicator();
              }
            })
      ),
    );
  }
}