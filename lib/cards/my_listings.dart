import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  required bool state,
  required bool approved,
  required String userID,
}) {
  String userid = FirebaseAuth.instance.currentUser!.email.toString();
  if (userID == userid) {
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
                  "$propertyType\n$propertyTag | Price: Ksh. $propertyPrice\nLocation: $propertyLocation\nState: ${state ? (approved ? "Approved" : "Declined") : "Awaiting Review"}"),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          icon: const Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.red,
                          ),
                          title: const Text("Delete Inquiry"),
                          content: Text(
                              "Are you sure you want to delete $propertyName?"),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  Navigator.pop(ctx);
                                  await FirebaseStorage.instance
                                      .ref("property images/$id")
                                      .delete()
                                      .whenComplete(() => FirebaseFirestore
                                          .instance
                                          .collection("listings")
                                          .doc(id)
                                          .delete()
                                          .whenComplete(() => ScaffoldMessenger
                                                  .of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "$propertyName has been deleted.")))));
                                },
                                child: const Text("Yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: const Text("No")),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}
