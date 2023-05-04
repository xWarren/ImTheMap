import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:itm/ColorPalettes/color.dart';
import 'dart:async';

class SearchData extends StatefulWidget {
  const SearchData({Key? key}) : super(key: key);

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  final CollectionReference _search =
      FirebaseFirestore.instance.collection('search');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _resorttimeController = TextEditingController();
  final TextEditingController _contactinfoController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ratingsController = TextEditingController();

  String default_choice = "Angeles";
  int default_index = 0;

  List<MyChoice> choices = [
    MyChoice(index: 0, choice: "Angeles"),
    MyChoice(index: 1, choice: "Mabalacat"),
    MyChoice(index: 2, choice: "Magalang")
  ];

  /// Variables
  File? imageFile;

  String url = '';
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
  String pool = 'Swimming Pool';
  String lobby = 'Lobby';
  String room = 'Rooms';
  String dining = 'Dining';
  //create
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return StatefulBuilder(builder: (BuildContext context,
              void Function(void Function() function) setState) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: SingleChildScrollView(
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
                    SizedBox(height: 15),
                    Text('Location:', style: TextStyle(fontSize: 15)),
                    Wrap(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: choices
                                .map((data) => RadioListTile(
                                    title: Text('${data.choice}'),
                                    value: data.index,
                                    groupValue: default_index,
                                    onChanged: (value) {
                                      setState(() {
                                        default_choice = data.choice;
                                        default_index = data.index;
                                      });
                                    }))
                                .toList(),
                          ),
                        )
                      ],
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
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('search_images');

                        //Create a reference for the image to be stored
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);
                        String url;
                        //Handle errors or success
                        try {
                          //Store the file
                          await referenceImageToUpload
                              .putFile(File(imageFile!.path));
                          //Success: get download url
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                          url = imageUrl.toString();
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
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();
                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image1 =
                                  await referenceImageToUpload.getDownloadURL();
                              imageUrl = image1.toString();
                            } catch (error) {
                              //Some error occured
                            }
                          },
                          child: const Text("Pool Image 1"),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image2 =
                                  await referenceImageToUpload.getDownloadURL();
                              imageUrl = image2.toString();
                            } catch (error) {
                              //Some error occured
                            }
                          },
                          child: const Text("Pool Image 2"),
                        ),
                      ],
                    ),
                    //image 3 and 4
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
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image3 =
                                  await referenceImageToUpload.getDownloadURL();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image4 =
                                  await referenceImageToUpload.getDownloadURL();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);

                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image5 =
                                  await referenceImageToUpload.getDownloadURL();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image6 =
                                  await referenceImageToUpload.getDownloadURL();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image7 =
                                  await referenceImageToUpload.getDownloadURL();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);

                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image8 =
                                  await referenceImageToUpload.getDownloadURL();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              feedback1 =
                                  await referenceImageToUpload.getDownloadURL();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);

                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              feedback2 =
                                  await referenceImageToUpload.getDownloadURL();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

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
                          },
                          child: const Text("Feedback 3"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                        if (price != null) {
                          await _search.add({
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
                            "default_choice": default_choice,
                            "pool": pool,
                            "lobby": lobby,
                            "room": room,
                            "dining": dining,
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
                          default_choice = '';
                          pool;
                          lobby;
                          room;
                          dining;

                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          });
        });
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

  //update
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _detailsController.text = documentSnapshot['details'];
      _priceController.text = documentSnapshot['price'].toString();
      _resorttimeController.text = documentSnapshot['resorttime'];
      _contactinfoController.text = documentSnapshot['contactinfo'];
      _facebookController.text = documentSnapshot['facebook'];
      _locationController.text = documentSnapshot['location'];
      _ratingsController.text = documentSnapshot['ratings'];
      imageUrl = documentSnapshot['image'];
      image1 = documentSnapshot['image1'];
      image2 = documentSnapshot['image2'];
      image3 = documentSnapshot['image3'];
      image4 = documentSnapshot['image4'];
      image5 = documentSnapshot['image5'];
      image6 = documentSnapshot['image6'];
      image7 = documentSnapshot['image7'];
      image8 = documentSnapshot['image8'];
      feedback1 = documentSnapshot['feedback1'];
      feedback2 = documentSnapshot['feedback2'];
      feedback3 = documentSnapshot['feedback3'];
      default_choice = documentSnapshot['default_choice'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return StatefulBuilder(builder: (BuildContext context,
              void Function(void Function() function) setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 120,
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text('Update data',
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
                      decoration: const InputDecoration(labelText: 'Details'),
                    ),
                    TextField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                    ),
                    TextField(
                      controller: _resorttimeController,
                      decoration:
                          const InputDecoration(labelText: 'Resort Time'),
                    ),
                    TextField(
                      controller: _contactinfoController,
                      decoration:
                          const InputDecoration(labelText: 'Contact Info'),
                    ),
                    TextField(
                      controller: _facebookController,
                      decoration:
                          const InputDecoration(labelText: 'Facebook Link'),
                    ),
                    TextField(
                      controller: _locationController,
                      decoration:
                          const InputDecoration(labelText: 'Location Link'),
                    ),
                    TextField(
                      controller: _ratingsController,
                      decoration: const InputDecoration(labelText: 'Ratings'),
                    ),
                    SizedBox(height: 15),
                    Text('Location:', style: TextStyle(fontSize: 15)),
                    Wrap(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: choices
                                .map((data) => RadioListTile(
                                    title: Text('${data.choice}'),
                                    value: data.index,
                                    groupValue: default_index,
                                    onChanged: (value) {
                                      setState(() {
                                        default_choice = data.choice;
                                        default_index = data.index;
                                      });
                                    }))
                                .toList(),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                        //Reference referenceRoot = FirebaseStorage.instance.ref();
                        //Reference referenceDirImages =
                        //referenceRoot.child('images');

                        //Create a reference for the image to be stored
                        //Reference referenceImageToUpload =
                        //referenceDirImages.child(uniqueFileName);

                        Reference referenceImageToUpload = FirebaseStorage
                            .instance
                            .ref()
                            .child("search_images")
                            .child(uniqueFileName);
                        UploadTask uploadTask = referenceImageToUpload
                            .putFile(File(imageFile!.path));
                        TaskSnapshot taskSnapshot =
                            await uploadTask.whenComplete(() {});
                        await taskSnapshot.ref
                            .getDownloadURL()
                            .then((url) async {
                          url = imageUrl;
                        });
                        String url;
                        //Handle errors or success
                        try {
                          //Store the file
                          await referenceImageToUpload
                              .putFile(File(imageFile!.path));
                          //Success: get download url
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                          url = imageUrl.toString();
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
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();
                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

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
                              image1 =
                                  await referenceImageToUpload.getDownloadURL();
                              url = image1.toString();
                            } catch (error) {
                              //Some error occured
                            }
                          },
                          child: const Text("Pool Image 1"),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

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
                              image2 =
                                  await referenceImageToUpload.getDownloadURL();
                              url = image2.toString();
                            } catch (error) {
                              //Some error occured
                            }
                          },
                          child: const Text("Pool Image 2"),
                        ),
                      ],
                    ),
                    //image 3 and 4
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
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

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
                              image3 =
                                  await referenceImageToUpload.getDownloadURL();
                              url = image3.toString();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image4 =
                                  await referenceImageToUpload.getDownloadURL();
                              url = image4.toString();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image5 =
                                  await referenceImageToUpload.getDownloadURL();
                              url = image5.toString();
                            } catch (error) {
                              //Some error occured
                            }
                          },
                          child: const Text("Room 1"),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image6 =
                                  await referenceImageToUpload.getDownloadURL();
                              url = image6.toString();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image7 =
                                  await referenceImageToUpload.getDownloadURL();
                              url = image7.toString();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              image8 =
                                  await referenceImageToUpload.getDownloadURL();
                              url = image8.toString();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              feedback1 =
                                  await referenceImageToUpload.getDownloadURL();
                              url = feedback1.toString();
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(uniqueFileName);
                            //Handle errors or success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(imageFile!.path));
                              //Success: get download url
                              feedback2 =
                                  await referenceImageToUpload.getDownloadURL();
                              url = feedback2.toString();
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          ),
                          onPressed: () async {
                            if (imageUrl.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please upload an image')));
                            }
                            _getFromGallery();

                            if (imageFile == null) return;
                            String uniqueFileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            //Get a reference to storage root
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('search_images');

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
                              url = feedback3.toString();
                            } catch (error) {
                              //Some error occured
                            }
                          },
                          child: const Text("Feedback 3"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: const Center(child: Text('Update')),
                      onPressed: () async {
                        final String name = _nameController.text;
                        final String details = _detailsController.text;
                        final String price = _priceController.text;
                        final String resorttime = _resorttimeController.text;
                        final String contactinfo = _contactinfoController.text;
                        final String facebook = _facebookController.text;
                        final String location = _locationController.text;
                        final String ratings = _ratingsController.text;
                        if (price != null) {
                          await _search.doc(documentSnapshot!.id).update({
                            "name": name,
                            "price": price,
                            "details": details,
                            'resorttime': resorttime,
                            'contactinfo': contactinfo,
                            'facebook': facebook,
                            'location': location,
                            'ratings': ratings,
                            'image': imageUrl,
                            'image1': image1,
                            'image2': image2,
                            'image3': image3,
                            'image4': image4,
                            'image5': image5,
                            'image6': image6,
                            'image7': image7,
                            'image8': image8,
                            'feedback1': feedback1,
                            'feedback2': feedback2,
                            'feedback3': feedback3,
                            'default_choice': default_choice
                          });
                          _nameController.text = '';
                          _priceController.text = '';
                          _detailsController.text = '';
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
                          default_choice = '';
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  //delete
  Future<void> _delete(String productId) async {
    await _search.doc(productId).delete();

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
              stream: _search.orderBy('name', descending: false).snapshots(),
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
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorPalette.backgroundcolor
                                          .withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  iconColor: ColorPalette.buttons,
                                  title: Text(
                                    documentSnapshot['name'],
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(
                                      documentSnapshot['image'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _update(documentSnapshot);
                                            },
                                            icon: const Icon(Icons.edit)),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: new Text('Are you sure?'),
                                              content: new Text(
                                                  'Do you want to delete this data?'),
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
                  return const CircularProgressIndicator();
                }
              }),
        ),
        //create
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          backgroundColor: Colors.green.shade700,
          child: const Icon(Ionicons.add_outline),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

class MyChoice {
  String choice;
  int index;
  MyChoice({required this.index, required this.choice});
}
