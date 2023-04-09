import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heureux_properties/cards/my_properties.dart';

class MyProperties extends StatefulWidget {
  const MyProperties({Key? key}) : super(key: key);

  @override
  State<MyProperties> createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  String? userEmail = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Properties"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(userEmail)
              .collection("my properties")
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
                      Icons.business_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 128,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "You have not yet purchased any property",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }

            // TODO: get doc fields
            return ListView(
              children: [
                myPropertiesCard(
                    context: context, propertyImg: "assets/property1.jpg"),
              ],
            );
          }),
    );
  }
}
