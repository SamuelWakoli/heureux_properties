import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heureux_properties/pages/bookmarks.dart';

import '../pages/details.dart';
import '../pages/inquire.dart';
import '../utils.dart';
import 'card_functions.dart';

/// Creates a bookmark card widget at the Bookmarks Page
Widget bookmarkCard({
  required context,
  required String id,
  required String propertyDisplayImg,
  required String propertyName,
  required String propertyPrice,
  required String propertyLocation,
  required String propertyTag,
  required String propertyType,
}) {
  if (favoriteProperties.contains(id)) {
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
                    nextPage(context: context, page: const InquirePage());
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.cases_outlined),
                      SizedBox(width: 10),
                      Text("Inquire"),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
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
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () async {
                    favoriteProperties.remove(id);

                    Map<String, dynamic> data = {
                      "favorites": favoriteProperties
                    };

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userEmail)
                        .update(data)
                        .whenComplete(() => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                content: Text(
                                    "$propertyName has been removed from your bookmarks"))))
                        .whenComplete(() => nextPageReplace(
                            context: context, page: const Bookmarks()));
                  },
                  tooltip: "Remove",
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}
