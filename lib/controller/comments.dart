

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'package:itm/controller/search_page.dart';
final currentUser = FirebaseAuth.instance;
class Comments extends StatefulWidget {
  final String? uid;
  final String? name;
  final String? image;
  Comments({this.uid, this.name, this.image});

  @override
  State<Comments> createState() => _CommentsState(
      uid:this.uid,
      name: this.name,
      image: this.image
  );
}

class _CommentsState extends State<Comments> {
  TextEditingController commentsController = TextEditingController();
  final String? uid;
  final String? name;
  final String? image;
  _CommentsState({this.uid, this.name,this.image});

  buildComments() {
    return StreamBuilder(
      stream: commentsRef.doc("uid").collection("comments").orderBy("timestamp", descending:true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<Comment> comments = [];
        snapshot.data?.docs.forEach((doc) {
          comments.add(Comment.fromDocument(doc));
        });
        return ListView(
          children: comments,
        );
      });
  }
  addComment() {
    commentsRef
    .doc('uid')
        .collection('comments')
        .add({
      "displayName": currentUser.currentUser?.email,
      "comment": commentsController.text,
      "uid": currentUser.currentUser?.uid
    });
    commentsController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundcolor,
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentsController,
              decoration: InputDecoration(labelText: "Write a comment"),
            ),
            trailing: OutlinedButton(
                onPressed: addComment,
                child: Text("Post"),
            ),
          )
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String uid;
  final String displayName;

  final String comment;
  Comment({required this.uid, required this.comment, required this.displayName});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      displayName: doc['displayName'],
      comment: doc['comment'],
      uid: doc['uid'],


    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment),
        ),
        Divider(),
      ],
    );
  }
}
