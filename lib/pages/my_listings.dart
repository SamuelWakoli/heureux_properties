import 'package:flutter/material.dart';
import 'package:heureux_properties/cards/my_listings.dart';

class MyListingsPage extends StatefulWidget {
  const MyListingsPage({Key? key}) : super(key: key);

  @override
  State<MyListingsPage> createState() => _MyListingsPageState();
}

class _MyListingsPageState extends State<MyListingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Listings"),
      ),
      // TODO: add a FAB, to allow user add a property
      // navigate to the next page on click

      // use stream builder, if no item in lisings, show FAB

      // user "where" to get listings made by the user

      body: ListView(
        children: [
          myListingsCard(context: context, propertyImg: "assets/property1.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property2.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property3.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property4.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property5.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property6.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property1.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property2.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property3.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property4.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property5.jpg"),
          myListingsCard(context: context, propertyImg: "assets/property6.jpg"),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: "Add Property",
        // splashColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          size: 36,
          //color: Theme.of(context).primaryColor,
        ),
        onPressed: () {},
      ),
    );
  }
}
