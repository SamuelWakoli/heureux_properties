import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../pages/details.dart';
import '../pages/filter.dart';
import '../pages/inquire.dart';
import '../utils.dart';
import 'card_functions.dart';

/// Creates a Home Screen card widget
Widget filterCard({
  required context,
  required String id,
  required String propertyDisplayImg,
  required String propertyName,
  required String propertyPrice,
  required String cardPropertyLocation,
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
                  "$propertyType\n$propertyTag | Price: Ksh. $propertyPrice\nLocation: $cardPropertyLocation"),
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

  /// call these global variables when applying filter
// Property category
  //bool forRent = false, forLease = false, forSale = false, allCategory = true;

// Property type
  // bool farm = false, land = false, plot = false, ranch = false, allType = true;

// Property location
  // String propertyLocation = "All locations";

  // Filtering categories
  Widget filterCategories() {
    // 1. All categories, All types
    if (allCategory == true) {
      return showCard();
    }
    // 2. For Rent, All types
    if (forRent == true && propertyTag == "For Rent") {
      return showCard();
    }
    // 3. For Lease, All types
    if (forLease == true && propertyTag == "For Lease") {
      return showCard();
    }
    // 4. For Sale, All types
    if (forSale == true && propertyTag == "For Sale") {
      return showCard();
    }

    return const SizedBox();
  }

  // Filtering type
  Widget filterType() {
    if (allType == true) {
      return filterCategories();
    }
    if (farm == true && propertyType == "Farm") {
      return filterCategories();
    }
    if (land == true && propertyType == "Land") {
      return filterCategories();
    }
    if (plot == true && propertyType == "Plot") {
      return filterCategories();
    }
    if (ranch == true && propertyType == "Ranch") {
      return filterCategories();
    }
    return const SizedBox();
  }

  // Generally, filter using location selection
  if (cardPropertyLocation == "Eldoret" && propertyLocation == "Eldoret") {
    return filterType();
  }
  if (cardPropertyLocation == "Githunguri" &&
      propertyLocation == "Githunguri") {
    return filterType();
  }
  if (cardPropertyLocation == "Juja" && propertyLocation == "Juja") {
    return filterType();
  }
  if (cardPropertyLocation == "Kabete" && propertyLocation == "Kabete") {
    return filterType();
  }
  if (cardPropertyLocation == "Kiambu" && propertyLocation == "Kiambu") {
    return filterType();
  }
  if (cardPropertyLocation == "Kikuyu" && propertyLocation == "Kikuyu") {
    return filterType();
  }
  if (cardPropertyLocation == "Laikipia" && propertyLocation == "Laikipia") {
    return filterType();
  }
  if (cardPropertyLocation == "Malaa" && propertyLocation == "Malaa") {
    return filterType();
  }
  if (cardPropertyLocation == "Matuu" && propertyLocation == "Matuu") {
    return filterType();
  }
  if (cardPropertyLocation == "Mombasa" && propertyLocation == "Mombasa") {
    return filterType();
  }
  if (cardPropertyLocation == "Nairobi" && propertyLocation == "Nairobi") {
    return filterType();
  }
  if (cardPropertyLocation == "Naivasha" && propertyLocation == "Naivasha") {
    return filterType();
  }
  if (cardPropertyLocation == "Nakuru" && propertyLocation == "Nakuru") {
    return filterType();
  }
  if (cardPropertyLocation == "Ruaka" && propertyLocation == "Ruaka") {
    return filterType();
  }
  if (cardPropertyLocation == "Syokimau" && propertyLocation == "Syokimau") {
    return filterType();
  }
  if (cardPropertyLocation == "Thika" && propertyLocation == "Thika") {
    return filterType();
  }
  if (propertyLocation == "All locations") {
    return filterType();
  }
  return const SizedBox();
}
