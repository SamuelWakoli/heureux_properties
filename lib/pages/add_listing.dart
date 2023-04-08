import 'package:flutter/material.dart';
import 'package:heureux_properties/pages/add_listing_img1.dart';
import 'package:heureux_properties/utils.dart';

class AddListingPage extends StatefulWidget {
  const AddListingPage({Key? key}) : super(key: key);

  @override
  State<AddListingPage> createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  String? propertyName, propertyLocation, propertyPrice, shortDescription;

  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Property Listing"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const Text(
                  "To sell/rent/lease your property with us, fill in this form,"
                  " and include 5 images of your property. Upon submission of "
                  "this form, we will review it and contact your for more "
                  "inspection of the property before approval."),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                onChanged: (value) async {
                  propertyName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter name of your property';
                  }
                },
                decoration: InputDecoration(
                  label: const Text("Property Name"),
                  isCollapsed: false,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                onChanged: (value) async {
                  propertyLocation = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter location of your property';
                  }
                },
                decoration: InputDecoration(
                  label: const Text("Location"),
                  isCollapsed: false,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onChanged: (value) async {
                  propertyPrice = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter price of your property';
                  }
                },
                decoration: InputDecoration(
                  label: const Text("Price"),
                  hintText: "(Ksh)",
                  isCollapsed: false,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChanged: (value) async {
                  shortDescription = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter short description of your property';
                  }
                },
                minLines: 6,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Description of your property",
                  isCollapsed: false,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                    nextPage(context: context, page: const AddListingImg1());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_outlined),
                      const SizedBox(width: 20),
                      Text(
                        "Add Images",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.navigate_next),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
