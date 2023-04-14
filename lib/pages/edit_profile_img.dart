import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileImg extends StatefulWidget {
  const EditProfileImg({Key? key}) : super(key: key);

  @override
  State<EditProfileImg> createState() => _EditProfileImgState();
}

class _EditProfileImgState extends State<EditProfileImg> {
  String userprofileUrl =
      FirebaseAuth.instance.currentUser!.photoURL.toString();
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();

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
      return SizedBox(
        width: 200,
        height: 200,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.file(
              image!,
              fit: BoxFit.fill,
            )),
      );
    } else {
      // return current image
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            height: 160,
            width: 160,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: userprofileUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Theme.of(context).primaryColor,
              ),
              errorWidget: (cx, url, downloadProgress) {
                return const Center(
                    child: Text(
                  "no image selected",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ));
              },
            ),
          ),
        ),
      );
    }
  }

  bool loading = false, showErrorText = false, navigatedToNextPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Profile Picture"),
      ),
      body: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Select image from:",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
              onPressed: () async => pickImageGallery(),
              child: SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image_outlined,
                      size: 32,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "Gallery",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 12),
          OutlinedButton(
              onPressed: () async => pickImageCamera(),
              child: SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_outlined,
                      size: 32,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "Camera",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 30),
          _getImage(),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () async {
                if (image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select an image to be saved"),
                    ),
                  );
                } else {
                  String photoURL = "";

                  setState(() {
                    loading = true;
                  });

                  await FirebaseStorage.instance
                      .ref("users/$userEmail")
                      .child("ProfilePhoto.png")
                      .putFile(image!)
                      .then((snapshot) async {
                    photoURL = await snapshot.ref.getDownloadURL();
                  }).whenComplete(() async {
                    if (photoURL != "") {
                      await FirebaseAuth.instance.currentUser!
                          .updatePhotoURL(photoURL)
                          .whenComplete(() {
                        setState(() {
                          loading = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Profile picture saved successfully"),
                          ),
                        );
                        Navigator.of(context).pop();
                      });
                    } else {
                      setState(() {
                        loading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Please ensure you have a well set internet connection and try again"),
                        ),
                      );
                    }
                  });
                }
              },
              child: SizedBox(
                width: 200,
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            size: 32,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
              )),
        ],
      ),
    );
  }
}
