import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heureux_properties/pages/help_support.dart';
import 'package:heureux_properties/pages/payment_information.dart';
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
  String? userPhone;
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
                                        page: const ProfilePage());
                                  }).onError((error, stackTrace) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "An error occurred: $error")));
                                    nextPageReplace(
                                        context: context,
                                        page: const ProfilePage());
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
                      title: Text(username!,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              editingName = true;
                            });
                          },
                          tooltip: "Edit username",
                          icon: const Icon(Icons.edit)),
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
                              child: const Text("Cancel")),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              initialValue: userEmail,
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
                          const SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: () async {
                                if (newEmail != "") {
                                  setState(() {
                                    editingEmail = false;
                                    loading = true;
                                  });
                                  await FirebaseAuth.instance.currentUser!
                                      .updateEmail(newEmail)
                                      .whenComplete(() {
                                    nextPageReplace(
                                        context: context,
                                        page: const ProfilePage());
                                  }).onError((error, stackTrace) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "An error occurred: $error")));
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            icon:
                                                const Icon(Icons.mail_outlined),
                                            title: const Text("Edit Email"),
                                            content: const Text(
                                                "Please note: To edit your email for a second time, please logout and login again."),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(ctx),
                                                  child: const Text("Okay"))
                                            ],
                                          );
                                        });
                                    nextPageReplace(
                                        context: context,
                                        page: const ProfilePage());
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
                      title: Text(userEmail!,
                          style: const TextStyle(fontSize: 20)),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              editingEmail = true;
                            });
                          },
                          tooltip: "Edit email",
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

                            return Text(userPhone!,
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
              ListTile(
                title: isEmailVerified
                    ? const Text("Email: Verified")
                    : Text.rich(
                        TextSpan(text: "Email not verified. ", children: [
                        TextSpan(
                            text: "Click here to verify",
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        icon: const Icon(Icons.email_outlined),
                                        title: const Text("Email Verification"),
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
                                                          icon: const Icon(Icons
                                                              .email_outlined),
                                                          title: const Text(
                                                              "Email Verification"),
                                                          content: Text(
                                                              "An email containing the verification link has been sent to $userEmail. Please check your inbox to complete the verification."),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      ctx);
                                                                },
                                                                child:
                                                                    const Text(
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
                                              child: const Text("Yes")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(ctx);
                                              },
                                              child: const Text("No")),
                                        ],
                                      );
                                    });
                              })
                      ])),
              )
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
                title: const Text("Payment History"),
                onTap: () =>
                    nextPage(context: context, page: const PaymentInfo()),
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
                onTap: () =>
                    nextPage(context: context, page: const HelpSupport()),
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
