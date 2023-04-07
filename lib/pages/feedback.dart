import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String feedbackText = '';

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
              maxLines: 8,
              decoration: InputDecoration(
                labelText: 'Type here:',
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
                // if (issueText == '') {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text('Please type your issue'),
                //     ),
                //   );
                // } else {
                //   Map<String, dynamic> data = {
                //     'issue': issueText,
                //     'read': false
                //   };
                //   await FirebaseFirestore.instance
                //       .collection('issues')
                //       .doc("${getUserName()} ${DateTime.now()}")
                //       .set(data)
                //       .whenComplete(
                //     () {
                //       showDialog(
                //           context: context,
                //           builder: (ctx) {
                //             return const AlertDialog(
                //               title: Text('Report Sent'),
                //               content: Text(
                //                   'Thank you for reporting an issue to us. We will review it fix it.'),
                //             );
                //           });
                //     },
                //   );
                // }
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
