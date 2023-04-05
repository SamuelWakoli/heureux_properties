import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Help and Support"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Icon(
              Icons.help_outline,
              color: Theme.of(context).primaryColor,
              size: 128,
            ),
          ),
          SizedBox(height: 180),
          const ListTile(
            title: Text("We are here to help with any questions or concerns"),
          ),
          ListTile(
            title: const Text("Call us"),
            subtitle: const Text("+254797228948"),
            trailing: IconButton(
                onPressed: () {
                  makePhoneCall("+254797228948");
                },
                icon: const Icon(
                  Icons.phone_outlined,
                  color: Colors.blue,
                )),
          ),
          ListTile(
            title: const Text("Email us"),
            subtitle: const Text("info@heureuxproperties.co.ke"),
            trailing: IconButton(
                onPressed: () {
                  // TODO: Create function to open Gmail
                },
                icon: Icon(
                  Icons.email_outlined,
                  color: Theme.of(context).primaryColor,
                )),
          ),
          ListTile(
            title: const Text("WhatsApp"),
            subtitle: const Text("+254797228948"),
            trailing: IconButton(
                onPressed: () {
                  openWhatsApp(context: context);
                },
                icon: Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.green,
                )),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
