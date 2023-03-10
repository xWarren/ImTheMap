import 'package:flutter/material.dart';

class LagoExtends extends StatefulWidget {
  const LagoExtends({Key? key}) : super(key: key);

  @override
  State<LagoExtends> createState() => _LagoExtendsState();
}

class _LagoExtendsState extends State<LagoExtends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("hello"), accountEmail: Text("hello")),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            hoverColor: Colors.blue,
            focusColor: Colors.yellow,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Text("welcome")));
            },
          )
        ],
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                color: Colors.yellow,
                child: Text("Welcome"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
