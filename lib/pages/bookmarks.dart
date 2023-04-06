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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bookmarks'),
      ),
      body: ListView(
        children: [
          bookmarkCard(context: context, propertyImg: "assets/property1.jpg"),
          bookmarkCard(context: context, propertyImg: "assets/property2.jpg"),
          bookmarkCard(context: context, propertyImg: "assets/property3.jpg"),
          bookmarkCard(context: context, propertyImg: "assets/property4.jpg"),
          bookmarkCard(context: context, propertyImg: "assets/property5.jpg"),
          bookmarkCard(context: context, propertyImg: "assets/property6.jpg"),
        ],
      ),
    );
  }
}
