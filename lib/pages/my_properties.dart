import 'package:flutter/material.dart';

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
    );
  }
}
