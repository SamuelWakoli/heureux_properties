import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
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
                        errorWidget: (cx, url, downloadProgress) => const Text(
                          "click here to set profile picture",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      FirebaseAuth.instance.currentUser!.displayName.toString(),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(FirebaseAuth.instance.currentUser!.email.toString(),
                      style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
                      style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 80,
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
                  Icons.collections_bookmark_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text("Saved Properties"),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
