import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'add_listing.dart';
import 'add_listing_img1.dart';
import 'filter.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  bool loading = false, showTxtField = false, navigatedToNextPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Property Location"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Eldoret",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Eldoret")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Githunguri",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Githunguri")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Juja",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Juja")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Kabete",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Kabete")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Kiambu",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Kiambu")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Kikuyu",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Kikuyu")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Laikipia",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Laikipia")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Malaa",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Malaa")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Matuu",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Matuu")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Mombasa",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Mombasa")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Nairobi",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Nairobi")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Naivasha",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Naivasha")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Nakuru",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Nakuru")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Ruaka",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Ruaka")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Syokimau",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Syokimau")),
                ),
                SizedBox(
                  width: 136,
                  child: RadioMenuButton(
                      value: "Thika",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = value!;
                          showTxtField = false;
                        });
                      },
                      child: const Text("Thika")),
                ),
                SizedBox(
                  width: 200,
                  child: RadioMenuButton(
                      value: "",
                      groupValue: propertyLocation,
                      onChanged: (value) {
                        setState(() {
                          propertyLocation = "";
                          showTxtField = true;
                        });
                      },
                      child: const Text("Other location")),
                ),
              ],
            ),
            SizedBox(height: 20),
            showTxtField
                ? TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) async {
                      propertyLocation = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter location of your property';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: const Text("Type here Location:"),
                      isCollapsed: false,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                : SizedBox(),
            const SizedBox(height: 20),
            OutlinedButton(
                onPressed: () async {
                  if (propertyLocation != "") {
                    Map<String, dynamic> propertyData = {
                      "location": propertyLocation,
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
                        .update(propertyData)
                        .whenComplete(() {
                      setState(() {
                        loading = false;
                      });

                      navigatedToNextPage = true;

                      return nextPage(
                          context: context, page: const AddListingImg1());
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
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Property location cannot be empty")));
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
                          const Icon(Icons.camera_outlined),
                          const SizedBox(width: 20),
                          Text(
                            "Add Images",
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
    );
  }
}
