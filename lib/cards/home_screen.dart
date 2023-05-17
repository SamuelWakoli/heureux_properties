import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heureux_properties/pages/inquire.dart';
import 'package:like_button/like_button.dart';

import '../pages/details.dart';
import '../utils.dart';
import 'card_functions.dart';

/// Creates a Home Screen card widget
Widget homeCard({
  required context,
  required String id,
  required String propertyDisplayImg,
  required String propertyName,
  required String propertyPrice,
  required String propertyLocation,
  required String propertyTag,
  required String propertyType,
}) {
  Widget showCard() {
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
                LikeButton(
                  isLiked: favoriteProperties.contains(id),
                  bubblesColor: BubblesColor(
                      dotPrimaryColor: Theme.of(context).primaryColor,
                      dotSecondaryColor: Colors.white),
                  circleColor: CircleColor(
                    start: Theme.of(context).primaryColor,
                    end: Colors.white,
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.bookmark,
                      color: isLiked
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      size: 32,
                    );
                  },
                  onTap: ((isLiked) async {
                    if (doesUserExists!) {
                      if (!isLiked) {
                        favoriteProperties.add(id);
                      } else {
                        favoriteProperties.remove(id);
                      }

                      Map<String, dynamic> data = {
                        "favorites": favoriteProperties
                      };

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userEmail)
                          .update(data)
                          .whenComplete(() {
                        String likeMessage = "";
                        isLiked
                            ? likeMessage = "removed from"
                            : likeMessage = "added to";
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "$propertyName $likeMessage to bookmarks")));
                      });

                      return !isLiked;
                    }
                    return null;
                  }),
                ),
                const SizedBox(width: 30),
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  return showCard();
}
