import 'package:flutter/material.dart';

import '../pages/details.dart';
import '../pages/inquire.dart';
import '../utils.dart';
import 'card_functions.dart';

/// Creates a bookmark card widget at the Bookmarks Page
Widget bookmarkCard(
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
                child: Image.asset(
                  propertyImg,
                  fit: BoxFit.fitWidth,
                )),
          ),
          const ListTile(
            title: Text("Property Name"),
            subtitle: Text(
                "For Sale | Price: Ksh. 1,000,000\nLocation: propertyLocation"),
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
              SizedBox(width: 10),
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
              SizedBox(width: 30),
              IconButton(
                onPressed: () {},
                tooltip: "Remove",
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    ),
  );
}
