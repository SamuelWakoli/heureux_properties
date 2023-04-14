import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'add_listing.dart';

class AddListingImg5 extends StatefulWidget {
  const AddListingImg5({Key? key}) : super(key: key);

  @override
  State<AddListingImg5> createState() => _AddListingImg5State();
}

class _AddListingImg5State extends State<AddListingImg5> {
  File? image;

  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  Widget _getImage() {
    if (image != null) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 360,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.file(
                  image!,
                  fit: BoxFit.fill,
                )),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                if (image != null) {
                  // after 20 seconds, if not navigated to the next page, tell
                  // user to try agan
                  Timer(const Duration(seconds: 20), () {
                    if (!navigatedToNextPage) {
                      setState(() {
                        loading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please ensure you are connected to the internet and try again'),
                          duration: Duration(seconds: 4),
                        ),
                      );
                    }
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Uploading image...'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  setState(() {
                    loading = true;
                  });

                  String? img5URL;

                  // upload image to storage
                  await FirebaseStorage.instance
                      .ref("property images")
                      .child("$propertyID/image 5.png")
                      .putFile(image!)
                      .then((snapshot) async {
                    img5URL = await snapshot.ref.getDownloadURL();
                  }).whenComplete(() async {
                    // upload image url
                    if (img5URL != null) {
                      Map<String, dynamic> data = {"img 5 URL": img5URL};
                      await FirebaseFirestore.instance
                          .collection("listings")
                          .doc(propertyID)
                          .update(data)
                          .whenComplete(() {
                        setState(() {
                          loading = false;
                        });
                        navigatedToNextPage = true;
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                icon: Icon(
                                  Icons.business_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: const Text("Submission Successful!"),
                                content: const Text(
                                    "We have received your request "
                                    "for listing your property in our app. We will "
                                    "contact you for any information needed before "
                                    "further inspections and approval"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.home_outlined),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("Open Home Page"),
                                        ],
                                      ))
                                ],
                              );
                            });
                      }).onError((error, stackTrace) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $error"))));
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Please add property display image to continue')),
                  );
                }
              },
              child: loading
                  ? Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Submit',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor)),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.done,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    )),
        ],
      );
    } else {
      return const SizedBox(height: 30);
    }
  }

  bool loading = false, navigatedToNextPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Property Images"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            ListTile(
              title: Text(
                "Add fifth image:",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => pickImageGallery(),
                      child: SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 10),
                            Text('Gallery',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor)),
                          ],
                        ),
                      )),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () => pickImageCamera(),
                      child: SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 10),
                            Text('Camera',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor)),
                          ],
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 8),
              _getImage(),
            ]),
          ]),
        ),
      ),
    );
  }
}
