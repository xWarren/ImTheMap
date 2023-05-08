// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Homess extends StatefulWidget {
  const Homess({super.key});

  @override
  _HomessState createState() => _HomessState();
}

class _HomessState extends State<Homess> {
  final picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 25,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.download_rounded),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      pickedFile = picker
                          // ignore: deprecated_member_use
                          .getImage(source: ImageSource.camera)
                          .whenComplete(() => {setState(() {})});
                    },
                    icon: const Icon(Icons.add)),
                const SizedBox(
                  width: 100,
                ),
                IconButton(
                  onPressed: () async {
                    pickedFile = picker
                        // ignore: deprecated_member_use
                        .getImage(
                            source: ImageSource.gallery,
                            maxHeight: 50,
                            maxWidth: 50)
                        .whenComplete(() => {setState(() {})});
                  },
                  icon: const Icon(Icons.photo_camera_back),
                ),
              ],
            ),
            FutureBuilder<PickedFile?>(
              future: pickedFile,
              builder: (context, snap) {
                if (snap.hasData) {
                  return Container(
                    color: Colors.blue,
                    child: Image.file(
                      File(snap.data!.path),
                      fit: BoxFit.contain,
                    ),
                  );
                }
                return Container(
                  height: 100.0,
                  color: Colors.blue,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
