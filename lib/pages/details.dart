import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../cards/card_functions.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

/// This page uses [currentPropertyID] to load property details.
class _DetailsPageState extends State<DetailsPage> {
  /// Creates a Details Page card widget
  Widget _displayImg(
      {required context,
      id,
      required String propertyImg,
      propertyName,
      propertyPrice,
      propertyLocation}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(
                    propertyImg,
                    fit: BoxFit.fitWidth,
                  )),
            ),
          ),
          const SizedBox(height: 20),
          const ListTile(
            title: Text.rich(
              TextSpan(
                  text: "Property Name\n",
                  style: TextStyle(fontSize: 20),
                  children: [
                    TextSpan(
                      text:
                          "For Sale\nPrice: Ksh. 1,000,000\nLocation: propertyLocation\n",
                      style: TextStyle(fontSize: 18),
                    ),
                  ]),
            ),
            subtitle: Text.rich(TextSpan(
                text: "Property description text Property description text "
                    "Property description text Property description text "
                    "Property description text Property description text "
                    "Property description text Property description text",
                style: TextStyle(fontSize: 16))),
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
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(
            value: downloadProgress.progress,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
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
      body: ListView(
        children: [
          _displayImg(context: context, propertyImg: "assets/property1.jpg"),
        ],
      ),
    );
  }
}
