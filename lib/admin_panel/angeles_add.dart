import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:async';

class AngelesAdd extends StatefulWidget {
  const AngelesAdd({super.key});

  @override
  State<AngelesAdd> createState() => _AngelesAddState();
}

class _AngelesAddState extends State<AngelesAdd> {
  final CollectionReference _angeles =
      FirebaseFirestore.instance.collection('angeles');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _resorttimeController = TextEditingController();
  final TextEditingController _contactinfoController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ratingsController = TextEditingController();

  /// Variables
  File? imageFile;

  String imageName = '';
  String imageUrl = '';
  String image1 = '';
  String image2 = '';
  String image3 = '';
  String image4 = '';
  String image5 = '';
  String image6 = '';
  String image7 = '';
  String image8 = '';
  String feedback1 = '';
  String feedback2 = '';
  String feedback3 = '';
  //create
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text('Add Data',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _detailsController,
              decoration: const InputDecoration(
                labelText: 'Details',
              ),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
            ),
            TextField(
              controller: _resorttimeController,
              decoration: const InputDecoration(
                labelText: 'Resort Time',
              ),
            ),
            TextField(
              controller: _contactinfoController,
              decoration: const InputDecoration(
                labelText: 'Contact Info',
              ),
            ),
            TextField(
              controller: _facebookController,
              decoration: const InputDecoration(
                labelText: 'Facebook Link',
              ),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location Link',
              ),
            ),
            TextField(
              controller: _ratingsController,
              decoration: const InputDecoration(
                labelText: 'Ratings',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
              ),
              onPressed: () async {
                _getFromGallery();

                if (imageFile == null) return;
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();

                //Get a reference to storage root
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');

                //Create a reference for the image to be stored
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);
                String url1;
                //Handle errors or success
                try {
                  //Store the file
                  await referenceImageToUpload.putFile(File(imageFile!.path));
                  //Success: get download url
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                  url1 = imageUrl.toString();
                } catch (error) {
                  //Some error occured
                }
              },
              child: const Text("Image"),
            ),

            Container(
              height: 40.0,
            ),
            //image 1 and 2
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please upload an image')));
                    }
                    _getFromGallery();
                    if (imageFile == null) return;
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);
                    //Handle errors or success
                    String url;
                    try {
                      //Store the file
                      await referenceImageToUpload
                          .putFile(File(imageFile!.path));
                      //Success: get download url
                      image1 = await referenceImageToUpload.getDownloadURL();
                      url = image1.toString();
                    } catch (error) {
                      //Some error occured
                    }
                  },
                  child: Text("Pool Image 1"),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please upload an image')));
                    }
                    _getFromGallery();

                    if (imageFile == null) return;
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);
                    //Handle errors or success
                    String url;
                    try {
                      //Store the file
                      await referenceImageToUpload
                          .putFile(File(imageFile!.path));
                      //Success: get download url
                      image2 = await referenceImageToUpload.getDownloadURL();
                      url = image2.toString();
                    } catch (error) {
                      //Some error occured
                    }
                  },
                  child: Text("Pool Image 2"),
                ),
              ],
            ),
            //image 3 and 4
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please upload an image')));
                    }
                    _getFromGallery();

                    if (imageFile == null) return;
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);
                    //Handle errors or success
                    try {
                      //Store the file
                      await referenceImageToUpload
                          .putFile(File(imageFile!.path));
                      //Success: get download url
                      image3 = await referenceImageToUpload.getDownloadURL();
                      imageUrl = image3.toString();
                    } catch (error) {
                      //Some error occured
                    }
                  },
                  child: const Text("Lobby 1"),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload an image')));
                    }
                    _getFromGallery();

                    if (imageFile == null) return;
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);
                    //Handle errors or success
                    try {
                      //Store the file
                      await referenceImageToUpload
                          .putFile(File(imageFile!.path));
                      //Success: get download url
                      image4 = await referenceImageToUpload.getDownloadURL();
                      imageUrl = image4.toString();
                    } catch (error) {
                      //Some error occured
                    }
                  },
                  child: const Text("Lobby 2"),
                ),
              ],
            ),
            //image 5 and 6
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload an image')));
                    }
                    _getFromGallery();

                    if (imageFile == null) return;
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);

                    //Handle errors or success
                    try {
                      //Store the file
                      await referenceImageToUpload
                          .putFile(File(imageFile!.path));
                      //Success: get download url
                      image5 = await referenceImageToUpload.getDownloadURL();
                      imageUrl = image5.toString();
                    } catch (error) {
                      //Some error occured
                    }
                  },
                  child: const Text("Room 1"),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload an image')));
                    }
                    _getFromGallery();

                    if (imageFile == null) return;
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);
                    //Handle errors or success
                    try {
                      //Store the file
                      await referenceImageToUpload
                          .putFile(File(imageFile!.path));
                      //Success: get download url
                      image6 = await referenceImageToUpload.getDownloadURL();
                      imageUrl = image6.toString();
                    } catch (error) {
                      //Some error occured
                    }
                  },
                  child: const Text("Room 2"),
                ),
              ],
            ),
            //image 7 and 8
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload an image')));
                    }
                    _getFromGallery();

                    if (imageFile == null) return;
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);
                    //Handle errors or success
                    try {
                      //Store the file
                      await referenceImageToUpload
                          .putFile(File(imageFile!.path));
                      //Success: get download url
                      image7 = await referenceImageToUpload.getDownloadURL();
                      imageUrl = image7.toString();
                    } catch (error) {
                      //Some error occured
                    }
                  },
                  child: const Text("Dining 1"),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload an image')));
                    }
                    _getFromGallery();

                    if (imageFile == null) return;
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);

                    //Handle errors or success
                    try {
                      //Store the file
                      await referenceImageToUpload
                          .putFile(File(imageFile!.path));
                      //Success: get download url
                      image8 = await referenceImageToUpload.getDownloadURL();
                      imageUrl = image8.toString();
                    } catch (error) {
                      //Some error occured
                    }
                  },
                  child: const Text("Dining 2"),
                ),
              ],
            ),
            //image 9 and 10
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload an image')));
                    }
                    _getFromGallery();

                    if (imageFile == null) return;
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);
                    //Handle errors or success
                    try {
                      //Store the file
                      await referenceImageToUpload
                          .putFile(File(imageFile!.path));
                      //Success: get download url
                      feedback1 = await referenceImageToUpload.getDownloadURL();
                      imageUrl = feedback1.toString();
                    } catch (error) {
                      //Some error occured
                    }
                  },
                  child: const Text("Feedback 1"),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload an image')));
                    }
                    _getFromGallery();

                    if (imageFile == null) return;
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);

                    //Handle errors or success
                    try {
                      //Store the file
                      await referenceImageToUpload
                          .putFile(File(imageFile!.path));
                      //Success: get download url
                      feedback2 = await referenceImageToUpload.getDownloadURL();
                      imageUrl = feedback2.toString();
                    } catch (error) {
                      //Some error occured
                    }
                  },
                  child: const Text("Feedback 2"),
                ),
              ],
            ),
            //image 11
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload an image')));
                    }
                    _getFromGallery();

                    if (imageFile != null) {
                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      //Get a reference to storage root
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('images');

                      //Create a reference for the image to be stored
                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);
                      //Handle errors or success
                      try {
                        //Store the file
                        await referenceImageToUpload
                            .putFile(File(imageFile!.path));
                        //Success: get download url
                        feedback3 =
                            await referenceImageToUpload.getDownloadURL();
                        imageUrl = feedback3.toString();
                      } catch (error) {
                        //Some error occured
                      }
                    }
                  },
                  child: const Text("Feedback 3"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Image:$imageUrl",
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
            ElevatedButton(
              child: const Center(child: Text('Create')),
              onPressed: () async {
                final String name = _nameController.text;
                final String details = _detailsController.text;
                final String price = _priceController.text;
                final String resorttime = _resorttimeController.text;
                final String contactinfo = _contactinfoController.text;
                final String facebook = _facebookController.text;
                final String location = _locationController.text;
                final String ratings = _ratingsController.text;
                await _angeles.add({
                  "name": name,
                  "details": details,
                  "price": price,
                  "resorttime": resorttime,
                  "contactinfo": contactinfo,
                  "facebook": facebook,
                  "location": location,
                  "ratings": ratings,
                  "image": imageUrl,
                  "image1": image1,
                  "image2": image2,
                  "image3": image3,
                  "image4": image4,
                  "image5": image5,
                  "image6": image6,
                  "image7": image7,
                  "image8": image8,
                  "feedback1": feedback1,
                  "feedback2": feedback2,
                  "feedback3": feedback3,
                });

                _nameController.text = '';
                _detailsController.text = '';
                _priceController.text = '';
                _resorttimeController.text = '';
                _contactinfoController.text = '';
                _facebookController.text = '';
                _locationController.text = '';
                _ratingsController.text = '';
                imageUrl = '';
                image1 = '';
                image2 = '';
                image3 = '';
                image4 = '';
                image5 = '';
                image6 = '';
                image7 = '';
                image8 = '';
                feedback1 = '';
                feedback2 = '';
                feedback3 = '';

                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}
