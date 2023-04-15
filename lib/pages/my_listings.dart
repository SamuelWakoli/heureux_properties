import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heureux_properties/cards/my_listings.dart';
import 'package:heureux_properties/pages/add_listing.dart';
import 'package:heureux_properties/utils.dart';

class MyListingsPage extends StatefulWidget {
  const MyListingsPage({Key? key}) : super(key: key);

  @override
  State<MyListingsPage> createState() => _MyListingsPageState();
}

class _MyListingsPageState extends State<MyListingsPage> {
  String? userEmail = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Listings"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("listings").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            }

            if (snapshot.data!.docs.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.business_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 128,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Click the button below to sell/lease your property with us",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView(
              children: snapshot.data!.docs
                  .map(
                    (doc) => myListingsCard(
                        context: context,
                        id: doc.id,
                        propertyDisplayImg: doc['img 1 URL'],
                        propertyName: doc['name'],
                        propertyPrice: doc['price'],
                        propertyLocation: doc['location'],
                        propertyTag: doc['tag'],
                        propertyType: doc['type'],
                        state: doc['state'],
                        userID: doc['user id'],
                        approved: doc['approved']),
                  )
                  .toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Property",
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          size: 36,
          //color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          nextPage(context: context, page: const AddListingPage());
        },
      ),
    );
  }
}
