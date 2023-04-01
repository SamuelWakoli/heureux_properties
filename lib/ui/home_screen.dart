import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    Icon(Icons.report_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Report Issue'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {},
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}
