import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

/// This function navigates to the next page by taking in context then adding
/// the intended page to the backstack
dynamic nextPage({required context, required page}) {
  Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.leftToRightWithFade, child: page));
}

/// This function navigates to the next page by taking in context then replacing
/// the intended page to the current page in the backstack
dynamic nextPageReplace({required context, required page}) {
  Navigator.pushReplacement(
      context,
      PageTransition(
          type: PageTransitionType.leftToRightWithFade, child: page));
}

/// Used to make phone calls.
Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

/// Used to open WhatsApp.
Future<void> openWhatsApp({required context}) async {
  final uri = Uri.parse("https://wa.me/254797228948");
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    // can't launch url
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to launch WhatsApp")));
  }
}
