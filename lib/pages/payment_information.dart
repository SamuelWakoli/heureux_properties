import 'package:flutter/material.dart';

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({Key? key}) : super(key: key);

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Payment History"),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
          ListTile(
            title: Text("PropertyName | Ksh. 20,000"),
            subtitle: Text("Date: 21/04/2022"),
          ),
        ],
      ),
    );
  }
}
