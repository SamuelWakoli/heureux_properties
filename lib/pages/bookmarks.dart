import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heureux_properties/cards/bookmarks.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    String? userEmail = FirebaseAuth.instance.currentUser!.email.toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bookmarks'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(userEmail)
              .collection("bookmarks")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark_remove_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 128,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "You have no bookmarks",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }

            return ListView(
                children: snapshot.data!.docs
                    .map((doc) => bookmarkCard(
                          context: context,
                          id: doc.id,
                          propertyDisplayImg: doc['img 1 URL'],
                          propertyName: doc['name'],
                          propertyPrice: doc['price'],
                          propertyLocation: doc['location'],
                          propertyTag: doc['tag'],
                          propertyType: doc['type'],
                        ))
                    .toList());
          }),
    );
  }
}
