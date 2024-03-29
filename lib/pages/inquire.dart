import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heureux_properties/cards/card_functions.dart';

import '../cards/inquiry.dart';
import '../utils.dart';

class InquirePage extends StatefulWidget {
  const InquirePage({Key? key}) : super(key: key);

  @override
  State<InquirePage> createState() => _InquirePageState();
}

/// This page uses [currentPropertyID] to load property details.
class _InquirePageState extends State<InquirePage> {
  String? username = FirebaseAuth.instance.currentUser!.displayName.toString();
  String? userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  String? userPhone;

  bool editingName = false;
  bool editingEmail = false;
  bool editingPhone = false;

  String newName = "", newEmail = "", newPhone = "";

  bool loading = false;

  String? inqPropertyName, inqPropertyLocation, inqPropertyPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Inquiry"),
      ),
      body: ListView(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("properties")
                  .doc(currentPropertyID)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ));
                }

                dynamic doc = snapshot.data;

                inqPropertyName = doc['name'];
                inqPropertyLocation = doc['location'];
                inqPropertyPrice = doc['price'];

                return inquiryCard(
                  context: context,
                  id: doc.id,
                  propertyDisplayImg: doc['img 1 URL'],
                  propertyName: doc['name'],
                  propertyPrice: doc['price'],
                  propertyLocation: doc['location'],
                  propertyTag: doc['tag'],
                  propertyType: doc['type'],
                );
              }),
          const SizedBox(height: 20),
          const ListTile(
            title: Text("Please confirm your information:"),
          ),
          editingName
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              editingName = false;
                            });
                          },
                          child: const Text("Cancel")),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          initialValue: username,
                          onChanged: (value) async {
                            newName = value;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            isCollapsed: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () async {
                            if (newName != "") {
                              setState(() {
                                editingName = false;
                                loading = true;
                              });
                              await FirebaseAuth.instance.currentUser!
                                  .updateDisplayName(newName)
                                  .whenComplete(() {
                                nextPageReplace(
                                    context: context,
                                    page: const InquirePage());
                              }).onError((error, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("An error occurred: $error")));
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("No changes made.")));
                            }
                          },
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ))
                              : const Text(
                                  "Save",
                                  style: TextStyle(fontSize: 18),
                                ))
                    ],
                  ),
                )
              : ListTile(
                  title: Text("Name: $username",
                      style: const TextStyle(
                        fontSize: 20,
                      )),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          editingName = true;
                        });
                      },
                      tooltip: "Edit username",
                      icon: const Icon(Icons.edit)),
                ),
          editingPhone
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              editingPhone = false;
                            });
                          },
                          child: const Text("Cancel")),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          initialValue: userPhone,
                          onChanged: (value) async {
                            newPhone = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: userPhone,
                            isCollapsed: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () async {
                            if (newPhone != "") {
                              setState(() {
                                editingPhone = false;
                                loading = true;
                              });

                              Map<String, dynamic> data = {
                                "name": username,
                                "phone": newPhone
                              };

                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userEmail)
                                  .set(data)
                                  .whenComplete(() {
                                setState(() {
                                  loading = false;
                                });
                              }).onError((error, stackTrace) {
                                setState(() {
                                  loading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("An error occurred: $error")));
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("No changes made.")));
                            }
                          },
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ))
                              : const Text(
                                  "Save",
                                  style: TextStyle(fontSize: 18),
                                ))
                    ],
                  ),
                )
              : ListTile(
                  title: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(userEmail)
                          .snapshots(),
                      builder: (context, snapshot) {
                        userPhone = "Edit phone number";

                        if (!snapshot.hasData) {
                          return Text(userPhone!,
                              style: const TextStyle(fontSize: 20));
                        }

                        if (!snapshot.data!.exists) {
                          return Text(userPhone!,
                              style: const TextStyle(fontSize: 20));
                        }
                        userPhone = snapshot.data!.get("phone").toString();

                        return Text("Phone: $userPhone",
                            style: const TextStyle(fontSize: 20));
                      }),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          editingPhone = true;
                        });
                      },
                      tooltip: "Edit Phone Number",
                      icon: const Icon(Icons.edit)),
                ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: OutlinedButton(
                style: ButtonStyle(
                    side: MaterialStateProperty.resolveWith((states) =>
                        BorderSide(color: Theme.of(context).primaryColor))),
                onPressed: () async {
                  Map<String, dynamic> inquiryData = {
                    "property ID": currentPropertyID,
                    "property name": inqPropertyName,
                    "property location": inqPropertyLocation,
                    "property price": inqPropertyPrice,
                    "user email": userEmail,
                    "username": username,
                    "user phone": userPhone,
                    "approved": false,
                  };

                  // update user data, so as to manage inquiries
                  Map<String, dynamic> userData = {
                    "phone": userPhone,
                    "name": username,
                  };

                  // First update user data
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(userEmail)
                      .update(userData) //then submit inquiry
                      .whenComplete(() async => await FirebaseFirestore.instance
                          .collection("inquiries")
                          .doc("${DateTime.now()}")
                          .set(inquiryData)
                          .whenComplete(() => showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  icon: const Icon(Icons.done_all_rounded),
                                  title: const Text("Inquiry Sent"),
                                  content: const Text(
                                      "We have received your inquiry, one "
                                      "of our agents will contact you within 4 hours"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.home_outlined),
                                            SizedBox(width: 10),
                                            Text("Home"),
                                          ],
                                        ))
                                  ],
                                );
                              })));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Submit Inquiry",
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        Icons.send_to_mobile_outlined,
                        size: 32,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
