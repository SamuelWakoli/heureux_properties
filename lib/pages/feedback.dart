import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String feedbackText = '';
  String? username = FirebaseAuth.instance.currentUser!.displayName.toString();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Feedback"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                feedbackText = value;
              },
              minLines: 8,
              maxLines: 16,
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
                if (feedbackText == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please type your feedback'),
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
                    'feedback': feedbackText,
                    'name': username,
                    'read': false
                  };

                  setState(() {
                    loading = true;
                  });

                  await FirebaseFirestore.instance
                      .collection('feedbacks')
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
                              title: Text('Feedback Sent'),
                              content: Text('Thank you for your feedback :)'),
                            );
                          });
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: loading
                    ? Center(
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            )))
                    : Row(
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
