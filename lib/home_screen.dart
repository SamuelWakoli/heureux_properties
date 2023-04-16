import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heureux_properties/connection_check.dart';
import 'package:heureux_properties/pages/about_us.dart';
import 'package:heureux_properties/pages/bookmarks.dart';
import 'package:heureux_properties/pages/feedback.dart';
import 'package:heureux_properties/pages/filter.dart';
import 'package:heureux_properties/pages/my_listings.dart';
import 'package:heureux_properties/pages/my_properties.dart';
import 'package:heureux_properties/pages/profile.dart';
import 'package:heureux_properties/pages/report_issue.dart';

import 'cards/card_functions.dart';
import 'cards/home_screen.dart';
import 'utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool? isInternetOn;

class _HomeScreenState extends State<HomeScreen> {
  // this is the styling text for Drawer Menu list tiles
  TextStyle drawerOptionsTextStyle = const TextStyle(fontSize: 16);

  String? userprofileUrl =
      FirebaseAuth.instance.currentUser!.photoURL.toString();
  String? username = FirebaseAuth.instance.currentUser!.displayName.toString();
  String? userEmail = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(), () async {
      // check if user does not exist
      dynamic userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userEmail);
      dynamic doc = await userDocRef.get();
      if (!doc.exists) {
        doesUserExists = false;
      } else {
        doesUserExists = true;
      }

      if (doesUserExists == true && doesUserExists != null) {
        favoriteProperties = await userDocRef.get("favoriteProperties");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Image.asset("assets/android12splash.png"),
            ),
            const SizedBox(width: 10),
            const Text(
              "Heureux properties",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () =>
                nextPage(context: context, page: const FilterPage()),
            icon: const Icon(Icons.filter_list_outlined),
            tooltip: "Filter",
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: const [
                    Icon(Icons.phone_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Call Us'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(FontAwesomeIcons.whatsapp),
                    SizedBox(
                      width: 20,
                    ),
                    Text('WhatsApp'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.report_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Report Issue'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 0:
                  // call us
                  makePhoneCall("+254797228948");
                  break;
                case 1:
                  // whatsapp
                  openWhatsApp(context: context);
                  break;
                case 2:
                  // report issue
                  nextPage(context: context, page: const ReportIssuePage());
                  break;
                default:
                // default statement
                // nothing
              }
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: CircleAvatar(
                radius: 64,
                backgroundColor: Colors.white,
                child: Image.asset("assets/android12splash.png"),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Center(
              child: Text(
                "Heureux Properties",
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Divider(),
            ),
            const SizedBox(
              height: 48,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: userprofileUrl!,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: Theme.of(context).primaryColor,
                          ),
                          errorWidget: (cx, url, downloadProgress) => Center(
                            child: Icon(
                              Icons.account_circle_outlined,
                              size: 46,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      "Profile",
                      style: drawerOptionsTextStyle,
                    ),
                    subtitle: Text(userEmail!),
                    onTap: () async {
                      dynamic connectivityResult =
                          await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.mobile) {
                        // I am connected to a mobile network.
                        isInternetOn = true;
                      } else if (connectivityResult ==
                          ConnectivityResult.wifi) {
                        // I am connected to a wifi network.
                        isInternetOn = true;
                      } else if (connectivityResult ==
                          ConnectivityResult.other) {
                        // I am connected to a network which is not in the above mentioned networks.
                        //isInternetOn = true;
                      } else if (connectivityResult ==
                          ConnectivityResult.none) {
                        // I am not connected to any network.
                        isInternetOn = false;
                      }

                      print("INTERNET CONN: $isInternetOn");
                      nextPage(
                          context: context,
                          page: isInternetOn!
                              ? const ProfilePage()
                              : const ConnectionCheck());
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(
                Icons.collections_bookmark_outlined,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Bookmarks",
                style: drawerOptionsTextStyle,
              ),
              onTap: () {
                nextPage(context: context, page: const Bookmarks());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.business,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "My Properties",
                style: drawerOptionsTextStyle,
              ),
              onTap: () {
                nextPage(context: context, page: const MyProperties());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.list_alt_rounded,
                size: 26,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "My Listings",
                style: drawerOptionsTextStyle,
              ),
              onTap: () {
                nextPage(context: context, page: const MyListingsPage());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback_outlined,
                size: 26,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Feedback",
                style: drawerOptionsTextStyle,
              ),
              onTap: () {
                nextPage(context: context, page: const FeedbackPage());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline_rounded,
                size: 26,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "About Us",
                style: drawerOptionsTextStyle,
              ),
              onTap: () {
                nextPage(context: context, page: const AboutUsPage());
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("properties").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text("No property added to the database"));
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((doc) => homeCard(
                        context: context,
                        id: doc.id,
                        propertyDisplayImg: doc['img 1 URL'],
                        propertyName: doc['name'],
                        propertyPrice: doc['price'],
                        propertyLocation: doc['location'],
                        propertyTag: doc['tag'],
                        propertyType: doc['type'],
                      ))
                  .toList(),
            );
          }),
    );
  }
}
