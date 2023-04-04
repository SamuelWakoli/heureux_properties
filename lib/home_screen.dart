import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heureux_properties/pages/about_us.dart';
import 'package:heureux_properties/pages/feedback.dart';
import 'package:heureux_properties/pages/filter.dart';
import 'package:heureux_properties/pages/my_listings.dart';
import 'package:heureux_properties/pages/notifications.dart';
import 'package:heureux_properties/pages/profile.dart';
import 'package:heureux_properties/pages/report_issue.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // this is the styling text for Drawer Menu list tiles
  TextStyle drawerOptionsTextStyle = const TextStyle(fontSize: 16);

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse("https://wa.me/254797228948");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // can't launch url
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Image.asset("assets/android12splash.png"),
            ),
            const SizedBox(width: 10),
            const Text(
              "Heureux Properties",
            )
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: const [
                    Icon(Icons.filter_list_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Filter'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
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
                value: 2,
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
                value: 3,
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
                  // filter
                  nextPage(context: context, page: const FilterPage());

                  break;
                case 1:
                  // call us
                  makePhoneCall("+254797228948");
                  break;
                case 2:
                  // whatsapp
                  _openWhatsApp();
                  break;
                case 3:
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

            // TODO: Replace this Tile when user created profile
            ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
                size: 26,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Profile",
                style: drawerOptionsTextStyle,
              ),
              onTap: () {
                nextPage(context: context, page: const ProfilePage());
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
                Icons.notifications_outlined,
                size: 26,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                "Notifications",
                style: drawerOptionsTextStyle,
              ),
              onTap: () {
                nextPage(context: context, page: const NotificationsPage());
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
    );
  }
}
