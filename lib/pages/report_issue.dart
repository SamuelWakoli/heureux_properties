import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  State<ReportIssuePage> createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  String issueText = '';
  String? username = FirebaseAuth.instance.currentUser!.displayName.toString();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Issue'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                issueText = value;
              },
              minLines: 8,
              maxLines: 16,
              cursorHeight: 22,
              cursorWidth: 2,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: 'Type here:',
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () async {
                if (issueText == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please type your issue'),
                    ),
                  );
                } else {
                  Timer(const Duration(seconds: 20), () {
                    setState(() {
                      loading = false;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please try again")));
                  });

                  Map<String, dynamic> data = {
                    'issue': issueText,
                    'username': username,
                    'read': false
                  };

                  setState(() {
                    loading = true;
                  });

                  await FirebaseFirestore.instance
                      .collection('issues')
                      .doc("${DateTime.now()}")
                      .set(data)
                      .whenComplete(
                    () {
                      setState(() {
                        loading = false;
                      });
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return const AlertDialog(
                              title: Text('Report Sent'),
                              content: Text(
                                  'Thank you for reporting an issue to us. We will take our time to review it.'),
                            );
                          });
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Send',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.send_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
