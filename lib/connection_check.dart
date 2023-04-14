import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heureux_properties/utils.dart';
import 'package:open_settings/open_settings.dart';

class ConnectionCheck extends StatefulWidget {
  const ConnectionCheck({Key? key}) : super(key: key);

  @override
  State<ConnectionCheck> createState() => _ConnectionCheckState();
}

class _ConnectionCheckState extends State<ConnectionCheck> {
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
                    // nextPage(context: context, page: const ReportIssuePage());
                    break;
                  default:
                  // default statement
                  // nothing
                }
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.signal_wifi_connected_no_internet_4_outlined,
                size: 64,
              ),
              const Text(
                "No Internet Connection",
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    OpenSettings.openWIFISetting();
                  },
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.wifi,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Open WiFi Settings",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    OpenSettings.openNetworkOperatorSetting();
                  },
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.towerCell,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Open Network Operator Settings",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text("Connect to the internet and open your profile again")
            ],
          ),
        ));
  }
}
