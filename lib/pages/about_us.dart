import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  TextStyle titleStyle = const TextStyle(fontSize: 18);
  TextStyle subTitleStyle = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About Us"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Buy or sell your Land or Plot with Heureux Properties.",
              style: titleStyle,
            ),
            subtitle: Text(
              "Our prices are not exaggerated and locations depend on where you want, ready for sale",
              style: subTitleStyle,
            ),
          ),
          ListTile(
            title: Text(
              "Who we are",
              style: titleStyle,
            ),
            subtitle: Text(
              "We are a real estate company that assists in the acquisition of good and well priced land/property",
              style: subTitleStyle,
            ),
          ),
          ListTile(
            title: Text(
              "Why are we unique?",
              style: titleStyle,
            ),
            subtitle: Text(
              "We have a track record of pleasing our clients by providing land/property that suites their wants at a good and favourable prices comparable to the current market",
              style: subTitleStyle,
            ),
          ),
          ListTile(
            title: Text(
              "Our Goal",
              style: titleStyle,
            ),
            subtitle: Text(
              "In the current real estate market, it's hard to find a company that focuses on their clients' needs. We are focusing on making our clients happy by providing property that suites their needs at a good and favourable prices.",
              style: subTitleStyle,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text("+254797228948"),
            subtitle: const Text("Call us"),
            leading: const Icon(
              Icons.phone_outlined,
              color: Colors.blue,
            ),
            onTap: () {
              makePhoneCall("+254797228948");
            },
          ),
          ListTile(
            title: const Text("+254797228948"),
            subtitle: const Text("Open WhatsApp"),
            leading: const Icon(
              FontAwesomeIcons.whatsapp,
              color: Colors.green,
            ),
            onTap: () {
              openWhatsApp(context: context);
            },
          ),
          ListTile(
            title: const Text("info@heureuxproperties.co.ke"),
            subtitle: const Text("Email us"),
            leading: Icon(
              Icons.email_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              // TODO: open Gmail
            },
          ),
          ListTile(
            title: const Text("Jetro Chambers(4th Floor), Westlands, Nairobi"),
            subtitle: const Text("Visit our office"),
            leading: Icon(
              Icons.location_on_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              // TODO: open Gmail
            },
          ),
          ListTile(
            title: const Text("www.heureuxproperties.co.ke"),
            subtitle: const Text("View our website"),
            leading: Icon(
              FontAwesomeIcons.chrome,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              // TODO: open Gmail
            },
          ),
        ],
      ),
    );
  }
}
