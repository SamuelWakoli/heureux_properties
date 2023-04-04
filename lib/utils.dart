import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
