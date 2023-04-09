import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Creates card for the My Listings Page
Widget myListingsCard(
    {required context,
    id,
    required propertyImg,
    propertyName,
    propertyPrice,
    propertyLocation}) {
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
                imageUrl: propertyImg,
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
            title: const Text("Property Name"),
            subtitle: Text(
                "For Sale | Price: Ksh. 1,000,000\nLocation: propertyLocation"),
            trailing: IconButton(
              tooltip: "Remove",
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    ),
  );
}
