import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ui/home_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    Future<void> makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            headerBuilder: (context, constraints, _) {
              return Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Image.asset("assets/android12splash.png"),
              );
            },
            footerBuilder: (context, action) {
              return Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text.rich(TextSpan(text: 'Need help? ', children: [
                    TextSpan(
                        text: 'Call Us',
                        style: const TextStyle(
                          //color: Theme.of(context).primaryColor,
                          color: Colors.deepPurple,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      icon: const Icon(
                                        Icons.phone_outlined,
                                        color: Colors.blue,
                                      ),
                                      title: const Text("Call Us"),
                                      content: const Text(
                                        "We're here to help with any questions or concerns you may have. Do you want to proceed with the call?",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          onPressed: () async {
                                            Navigator.of(ctx).pop();
                                            //call
                                            //when call permission is granted:
                                            await FlutterPhoneDirectCaller
                                                .callNumber('+254797228948');
                                            //else not granted, just show phone number
                                            if (await Permission
                                                .phone.isDenied) {
                                              makePhoneCall('+254797228948');
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(ctx).pop(),
                                          child: Container(
                                            padding: const EdgeInsets.all(14),
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                          })
                  ])));
            },
          );
        }
        return const HomeScreen();
      },
    );
  }
}
