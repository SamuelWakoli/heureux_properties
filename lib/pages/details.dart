import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../cards/card_functions.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

/// This page uses [currentPropertyID] to load property details.
class _DetailsPageState extends State<DetailsPage> {
  String? image1Url = "",
      image2Url = "",
      image3Url = "",
      image4Url = "",
      image5Url = "";

  /// Creates a Details Page card widget
  Widget _displayImg(
      {required context,
      required String propertyImg,
      required String propertyName,
      required String propertyPrice,
      required String propertyTag,
      required String propertyType,
      required String propertyDescription,
      required String propertyLocation}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: propertyImg,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: Text(propertyName, style: const TextStyle(fontSize: 18)),
            subtitle: Text.rich(TextSpan(
                text:
                    "$propertyType\n$propertyTag | Price: Ksh. $propertyPrice\nLocation: $propertyLocation\n\n",
                children: [
                  TextSpan(
                      text: propertyDescription,
                      style: const TextStyle(fontSize: 16))
                ])),
          ),
        ],
      ),
    );
  }

  /// Call this function to return an image of a property.
  /// Remember the 4 images, call this function 4 times in a list.
  Widget _getImages(String image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error_outline),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Details"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("properties")
              .doc(currentPropertyID)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            }

            final document = snapshot.data!;

            image1Url = document.get('img 1 URL');
            image2Url = document.get('img 2 URL');
            image3Url = document.get('img 3 URL');
            image4Url = document.get('img 4 URL');
            image5Url = document.get('img 5 URL');

            return ListView(
              children: [
                _displayImg(
                  context: context,
                  propertyImg: image1Url!,
                  propertyName: document['name'].toString(),
                  propertyPrice: document['price'].toString(),
                  propertyLocation: document['location'].toString(),
                  propertyType: document['type'].toString(),
                  propertyTag: document['tag'].toString(),
                  propertyDescription: document['description'].toString(),
                ),
                const SizedBox(height: 10),
                _getImages(image2Url!),
                _getImages(image3Url!),
                _getImages(image4Url!),
                _getImages(image5Url!),
              ],
            );
          }),
    );
  }
}
