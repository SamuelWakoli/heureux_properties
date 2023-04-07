import 'package:flutter/material.dart';

/// Creates card for the My Properties Page
Widget myPropertiesCard(
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
            title: Text("Property Name\nPrice: Ksh. 1,000,000"),
            subtitle: Text(
                "For Sale | Price: Ksh. 1,000,000\nLocation: propertyLocation\nFully Paid"),
          ),
        ],
      ),
    ),
  );
}
