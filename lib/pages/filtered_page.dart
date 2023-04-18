import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heureux_properties/cards/filter_card.dart';

class FilteredPage extends StatefulWidget {
  const FilteredPage({Key? key}) : super(key: key);

  @override
  State<FilteredPage> createState() => _FilteredPageState();
}

class _FilteredPageState extends State<FilteredPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Results:"),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("properties").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text("No property added to the database"));
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((doc) => filterCard(
                        context: context,
                        id: doc.id,
                        propertyDisplayImg: doc['img 1 URL'],
                        propertyName: doc['name'],
                        propertyPrice: doc['price'],
                        cardPropertyLocation: doc['location'],
                        propertyTag: doc['tag'],
                        propertyType: doc['type'],
                      ))
                  .toList(),
            );
          }),
    );
  }
}
