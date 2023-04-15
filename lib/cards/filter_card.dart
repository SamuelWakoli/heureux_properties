import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../pages/details.dart';
import '../pages/filter.dart';
import '../utils.dart';
import 'card_functions.dart';

/// Creates a Home Screen card widget
Widget filterCard({
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
                const SizedBox(width: 30),
                IconButton(
                    onPressed: () {
                      currentPropertyID = id;

                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      FirebaseStorage.instance
                                          .ref("property images")
                                          .child(id)
                                          .delete()
                                          .whenComplete(() async =>
                                              await FirebaseFirestore.instance
                                                  .collection("properties")
                                                  .doc(id)
                                                  .delete())
                                          .whenComplete(() => ScaffoldMessenger
                                                  .of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Property Deleted"))));
                                    },
                                    child: const Text("Yes")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text("No"))
                              ],
                            );
                          });
                    },
                    tooltip: "Delete",
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                    )),
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

    return const Center(child: Text("Property category not found"));
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
    return const Center(child: Text("Type not found"));
  }

  // Generally, filter using location selection
  if (propertyLocation == "Eldoret") {
    return filterType();
  }
  if (propertyLocation == "Githunguri") {
    return filterType();
  }
  if (propertyLocation == "Juja") {
    return filterType();
  }
  if (propertyLocation == "Kabete") {
    return filterType();
  }
  if (propertyLocation == "Kiambu") {
    return filterType();
  }
  if (propertyLocation == "Kikuyu") {
    return filterType();
  }
  if (propertyLocation == "Laikipia") {
    return filterType();
  }
  if (propertyLocation == "Malaa") {
    return filterType();
  }
  if (propertyLocation == "Matuu") {
    return filterType();
  }
  if (propertyLocation == "Mombasa") {
    return filterType();
  }
  if (propertyLocation == "Nairobi") {
    return filterType();
  }
  if (propertyLocation == "Naivasha") {
    return filterType();
  }
  if (propertyLocation == "Nakuru") {
    return filterType();
  }
  if (propertyLocation == "Ruaka") {
    return filterType();
  }
  if (propertyLocation == "Syokimau") {
    return filterType();
  }
  if (propertyLocation == "Thika") {
    return filterType();
  }
  if (propertyLocation == "All locations") {
    return filterType();
  }
  if (propertyLocation != "Eldoret" ||
      propertyLocation != "Githunguri" ||
      propertyLocation != "Juja" ||
      propertyLocation != "Kabete" ||
      propertyLocation != "Kiambu" ||
      propertyLocation != "Kikuyu" ||
      propertyLocation != "Laikipia" ||
      propertyLocation != "Malaa" ||
      propertyLocation != "Matuu" ||
      propertyLocation != "Mombasa" ||
      propertyLocation != "Nairobi" ||
      propertyLocation != "Naivasha" ||
      propertyLocation != "Nakuru" ||
      propertyLocation != "Ruaka" ||
      propertyLocation != "Syokimau" ||
      propertyLocation != "Thika" ||
      propertyLocation != "All locations") {
    return filterType();
  }
  return const Center(child: Text("Not found"));
}
