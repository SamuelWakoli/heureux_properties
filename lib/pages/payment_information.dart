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
        title: const Text("Payment information"),
      ),
    );
  }
}
