import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heureux_properties/pages/add_listing_img2.dart';
import 'package:heureux_properties/utils.dart';
import 'package:image_picker/image_picker.dart';

import 'add_listing.dart';

class AddListingImg1 extends StatefulWidget {
  const AddListingImg1({Key? key}) : super(key: key);

  @override
  State<AddListingImg1> createState() => _AddListingImg1State();
}

class _AddListingImg1State extends State<AddListingImg1> {
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

                  String? displayImgURL;

                  // upload image to storage
                  await FirebaseStorage.instance
                      .ref("property images")
                      .child("$propertyID/image 1.png")
                      .putFile(image!)
                      .then((snapshot) async {
                    displayImgURL = await snapshot.ref.getDownloadURL();
                  }).whenComplete(() async {
                    // upload image url
                    if (displayImgURL != null) {
                      Map<String, dynamic> data = {"img 1 URL": displayImgURL};
                      await FirebaseFirestore.instance
                          .collection("listings")
                          .doc(propertyID)
                          .update(data)
                          .whenComplete(() {
                        setState(() {
                          loading = false;
                        });
                        navigatedToNextPage = true;
                        return nextPage(
                            context: context, page: const AddListingImg2());
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
                        Text('Add 4 more images',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor)),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.navigate_next,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    )),
        ],
      );
    } else {
      return const SizedBox();
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
            const ListTile(
              title: Text(
                "Display Image",
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                "This is the image that will be used to show your "
                "property in our app. Select image from:",
                style: TextStyle(fontSize: 16),
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
