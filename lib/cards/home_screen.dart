import 'package:flutter/material.dart';
import 'package:heureux_properties/cards/card_functions.dart';

import '../pages/details.dart';
import '../pages/inquire.dart';
import '../utils.dart';

/// Creates a Home Screen card widget
Widget homeCard(
    {required context,
    id,
    required String propertyImg,
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
                  tooltip: "Bookmark",
                  icon: Icon(Icons.bookmark_add_outlined)),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    ),
  );
}
