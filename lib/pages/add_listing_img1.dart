import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heureux_properties/pages/add_listing_img2.dart';
import 'package:heureux_properties/utils.dart';
import 'package:image_picker/image_picker.dart';

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
          showErrorText ? const SizedBox(height: 10) : const SizedBox(),
          showErrorText
              ? const Text(
                  "Sorry, we were unable to upload your image. Please check"
                  " your internet connection and try again.")
              : const SizedBox(),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                if (image != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Uploading image...'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  setState(() {
                    loading = true;
                  });

                  nextPage(context: context, page: const AddListingImg2());

                  loading = false;
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
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
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

  bool loading = false, showErrorText = false, navigatedToNextPage = false;

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
              title: Text("Display Image"),
              subtitle: Text("This is the image that will be used to show your "
                  "property in our app. Select image from:"),
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
