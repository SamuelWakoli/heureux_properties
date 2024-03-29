import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../cards/card_functions.dart';
import '../utils.dart';
import 'add_location.dart';

class AddListingPage extends StatefulWidget {
  const AddListingPage({Key? key}) : super(key: key);

  @override
  State<AddListingPage> createState() => _AddListingPageState();
}

String propertyID =
    "${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}";

class _AddListingPageState extends State<AddListingPage> {
  String? username = FirebaseAuth.instance.currentUser!.displayName.toString();

  String? propertyName,
      propertyLocation,
      propertyPrice,
      propertyDescription,
      propertyTag,
      propertyType;

  bool loading = false, showLocations = false, navigatedToNextPage = false;

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
                  return null;
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
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onChanged: (value) async {
                  propertyPrice = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter price of your property';
                  }
                  return null;
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
                  propertyDescription = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter short description of your property';
                  }
                  return null;
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
              const Text("Select property tag:"),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    child: RadioMenuButton(
                      value: "For Sale",
                      groupValue: propertyTag,
                      onChanged: (value) {
                        setState(() {
                          propertyTag = value;
                        });
                      },
                      child: const Text("For Sale"),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: RadioMenuButton(
                      value: "For Lease",
                      groupValue: propertyTag,
                      onChanged: (value) {
                        setState(() {
                          propertyTag = value;
                        });
                      },
                      child: const Text("For Lease"),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: RadioMenuButton(
                      value: "For Rent",
                      groupValue: propertyTag,
                      onChanged: (value) {
                        setState(() {
                          propertyTag = value;
                        });
                      },
                      child: const Text("For Rent"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Select property type:"),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    child: RadioMenuButton(
                      value: "Farm",
                      groupValue: propertyType,
                      onChanged: (value) {
                        setState(() {
                          propertyType = value;
                        });
                      },
                      child: const Text("Farm"),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: RadioMenuButton(
                      value: "Land",
                      groupValue: propertyType,
                      onChanged: (value) {
                        setState(() {
                          propertyType = value;
                        });
                      },
                      child: const Text("Land"),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: RadioMenuButton(
                      value: "Plot",
                      groupValue: propertyType,
                      onChanged: (value) {
                        setState(() {
                          propertyType = value;
                        });
                      },
                      child: const Text("Plot"),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: RadioMenuButton(
                      value: "Ranch",
                      groupValue: propertyType,
                      onChanged: (value) {
                        setState(() {
                          propertyType = value;
                        });
                      },
                      child: const Text("Ranch"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                  onPressed: () async {
                    if (propertyTag == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select property tag."),
                        ),
                      );
                    }

                    if (_formKey.currentState!.validate() &&
                        propertyTag != null) {
                      Map<String, dynamic> propertyData = {
                        "id": propertyID,
                        "name": propertyName,
                        "price": propertyPrice,
                        "location": "",
                        "description": propertyDescription,
                        "tag": propertyTag,
                        "type": propertyType,
                        "user id": userEmail,
                        "username": username,
                        "state": false,
                        "approved": false,
                        "img 1 URL": "",
                        "img 2 URL": "",
                        "img 3 URL": "",
                        "img 4 URL": "",
                        "img 5 URL": "",
                      };

                      setState(() {
                        loading = true;
                      });

                      Timer(const Duration(seconds: 20), () {
                        if (!navigatedToNextPage) {
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please ensure you are connected to the internet and try again'),
                              duration: Duration(seconds: 4),
                            ),
                          );
                        }
                      });

                      await FirebaseFirestore.instance
                          .collection("listings")
                          .doc(propertyID)
                          .set(propertyData)
                          .whenComplete(() {
                        setState(() {
                          loading = false;
                        });

                        propertyLocation = "";
                        navigatedToNextPage = true;
                        return nextPage(
                            context: context, page: const AddLocation());
                      }).onError(
                        (error, stackTrace) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "An error occurred, PLease ensure you are connected to the internet"),
                          ),
                        ),
                      );

                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  child: loading
                      ? Center(
                          child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add Property Location",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
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
