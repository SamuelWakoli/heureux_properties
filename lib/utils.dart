import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

dynamic nextPage({required context, required page}) {
  Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.leftToRightWithFade, child: page));
}

dynamic nextPageReplace({required context, required page}) {
  Navigator.pushReplacement(
      context,
      PageTransition(
          type: PageTransitionType.leftToRightWithFade, child: page));
}
