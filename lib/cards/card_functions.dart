import 'package:firebase_auth/firebase_auth.dart';

/// This var [currentPropertyID] is to be used when navigating between screens;
/// It holds the property ID during navigation, this is used to load a property
/// in a new screen.
///
String? userEmail = FirebaseAuth.instance.currentUser!.email.toString();
String? currentPropertyID;
bool? doesUserExists;

List<String> favoriteProperties = [];
