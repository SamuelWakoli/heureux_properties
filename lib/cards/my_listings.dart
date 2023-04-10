import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Creates card for the My Listings Page
Widget myListingsCard({
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
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: propertyDisplayImg,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(propertyName),
            subtitle: Text(
                "$propertyType\n$propertyTag | Price: Ksh. $propertyPrice\nLocation: $propertyLocation"),
            trailing: IconButton(
              tooltip: "Remove",
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: Colors.red,
              ),
              onPressed: () {
                // tell admin to delete property listing
              },
            ),
          ),
        ],
      ),
    ),
  );
}
