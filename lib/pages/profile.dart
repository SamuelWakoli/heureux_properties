import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heureux_properties/utils.dart';

import 'edit_profile_img.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userprofileUrl =
      FirebaseAuth.instance.currentUser!.photoURL.toString();
  String? username = FirebaseAuth.instance.currentUser!.displayName.toString();
  String? userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  String? userPhone = FirebaseAuth.instance.currentUser!.phoneNumber.toString();
  bool isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  bool editingName = false;
  bool editingEmail = false;
  bool editingPhone = false;

  String newName = "", newEmail = "", newPhone = "";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (username == null || username == "" || username == "null") {
      username = "Edit username";
    }
    if (userPhone == null || userPhone == "" || userPhone == "null") {
      userPhone = "Edit phone number";
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: 0, child: Text("Edit Profile Image"))
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                nextPage(context: context, page: const EditProfileImg());
              }
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    nextPage(context: context, page: const EditProfileImg());
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      height: 160,
                      width: 160,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: userprofileUrl!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Theme.of(context).primaryColor,
                        ),
                        errorWidget: (cx, url, downloadProgress) =>
                            const Center(
                          child: Text(
                            "click here to set profile picture",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
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
                              child: Text("Cancel")),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              onChanged: (value) async {
                                newName = value;
                              },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: username,
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
                          SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  editingName = false;
                                  loading = true;
                                });
                                if (newName != "") {
                                  await FirebaseAuth.instance.currentUser!
                                      .updateDisplayName(newName)
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
                                            content: Text(
                                                "An error occurred: $error")));
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
                                  : Text(
                                      "Save",
                                      style: TextStyle(fontSize: 18),
                                    ))
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(username!,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(width: 10),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                editingName = true;
                              });
                            },
                            icon: Icon(Icons.edit))
                      ],
                    ),
              editingEmail
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  editingEmail = false;
                                });
                              },
                              child: Text("Cancel")),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              onChanged: (value) async {
                                newEmail = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: userEmail,
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
                          SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  editingEmail = false;
                                  loading = true;
                                });
                                if (newEmail != "") {
                                  await FirebaseAuth.instance.currentUser!
                                      .updateEmail(newEmail)
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
                                            content: Text(
                                                "An error occurred: $error")));
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
                                  : Text(
                                      "Save",
                                      style: TextStyle(fontSize: 18),
                                    ))
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userEmail!, style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                editingEmail = true;
                              });
                            },
                            icon: Icon(Icons.edit))
                      ],
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
                              child: Text("Cancel")),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
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
                          SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  editingPhone = false;
                                  loading = true;
                                });
                                if (newPhone != "") {
                                  Map<String, dynamic> data = {
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
                                            content: Text(
                                                "An error occurred: $error")));
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
                                  : Text(
                                      "Save",
                                      style: TextStyle(fontSize: 18),
                                    ))
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userPhone!, style: TextStyle(fontSize: 20)),
                        SizedBox(width: 10),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                editingPhone = true;
                              });
                            },
                            icon: Icon(Icons.edit))
                      ],
                    ),
              SizedBox(height: 20),
              isEmailVerified
                  ? const Text("Email: Verified")
                  : Text.rich(TextSpan(text: "Email not verified. ", children: [
                      TextSpan(
                          text: "Click here to verify",
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      icon: Icon(Icons.email_outlined),
                                      title: Text("Email Verification"),
                                      content: Text(
                                          "You are about to verify $userEmail. Do you want to continue?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              await FirebaseAuth
                                                  .instance.currentUser!
                                                  .sendEmailVerification()
                                                  .whenComplete(() {
                                                Navigator.pop(ctx);
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) {
                                                      return AlertDialog(
                                                        icon: Icon(Icons
                                                            .email_outlined),
                                                        title: Text(
                                                            "Email Verification"),
                                                        content: Text(
                                                            "An email containing the verification link has been sent to $userEmail. Please check your inbox to complete the verification."),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    ctx);
                                                              },
                                                              child: const Text(
                                                                  "Okay"))
                                                        ],
                                                      );
                                                    });
                                              }).onError((error, stackTrace) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "An error occurred: $error")));
                                              });
                                            },
                                            child: Text("Yes")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(ctx);
                                            },
                                            child: Text("No")),
                                      ],
                                    );
                                  });
                            })
                    ]))
            ],
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.payments_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text("Payment Information"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text("Help and Support"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text("Logout"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          icon: Icon(
                            Icons.logout_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: const Text("Logout"),
                          content: const Text(
                              "You are about to logout from your profile, do you want to continue?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                },
                                child: const Text("Yes")),
                            TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text("No")),
                          ],
                        );
                      });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
