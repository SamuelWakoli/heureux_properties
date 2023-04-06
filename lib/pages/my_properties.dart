import 'package:flutter/material.dart';
import 'package:heureux_properties/cards/my_properties.dart';

class MyProperties extends StatefulWidget {
  const MyProperties({Key? key}) : super(key: key);

  @override
  State<MyProperties> createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Properties"),
      ),
      body: ListView(
        children: [
          myPropertiesCard(
              context: context, propertyImg: "assets/property1.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property2.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property3.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property4.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property5.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property6.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property1.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property2.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property3.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property4.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property5.jpg"),
          myPropertiesCard(
              context: context, propertyImg: "assets/property6.jpg")
        ],
      ),
    );
  }
}
