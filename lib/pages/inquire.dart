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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Inquiry"),
      ),
      body: ListView(
        children: [
          inquiryCard(
              context: context,
              id: currentPropertyID,
              propertyImg: "assets/property1.jpg"),
          SizedBox(height: 20),
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

                              Map<String, dynamic> data = {"phone": newPhone};

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
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: OutlinedButton(
                style: ButtonStyle(
                    side: MaterialStateProperty.resolveWith((states) =>
                        BorderSide(color: Theme.of(context).primaryColor))),
                onPressed: () {},
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
                      SizedBox(width: 20),
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
