import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../pages/details.dart';
import '../utils.dart';
import 'card_functions.dart';

/// Creates card for the Inquiry  Page
Widget inquiryCard({
  required context,
  required String id,
  required String propertyDisplayImg,
  required String propertyName,
  required String propertyPrice,
  required String propertyLocation,
  required String propertyTag,
  required String propertyType,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(18.0)),
      elevation: 0,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: propertyDisplayImg,
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
          ListTile(
            title: Text(propertyName),
            subtitle: Text(
                "$propertyType\n$propertyTag | Price: Ksh. $propertyPrice\nLocation: $propertyLocation"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  currentPropertyID = id;
                  nextPage(context: context, page: const DetailsPage());
                },
                child: Row(
                  children: const [
                    Icon(Icons.info_outline_rounded),
                    SizedBox(width: 10),
                    Text("Details"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
