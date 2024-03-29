import 'package:flutter/material.dart';

var myPrimaryColor = const Color(0xFFBF9000);
var myPrimaryColorDark = const Color(0xFFFFC000);

var lightThemeData = ThemeData(
  primaryColor: myPrimaryColor,
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  indicatorColor: myPrimaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  cardTheme: CardTheme(
    elevation: 8,
    shadowColor: myPrimaryColor,
    surfaceTintColor: myPrimaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: myPrimaryColor)),
  ),
  drawerTheme: DrawerThemeData(surfaceTintColor: myPrimaryColor),
  popupMenuTheme: PopupMenuThemeData(surfaceTintColor: myPrimaryColor),
  dialogTheme: DialogTheme(surfaceTintColor: myPrimaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      surfaceTintColor: MaterialStateProperty.resolveWith((states) {
        return myPrimaryColor;
      }),
      textStyle: MaterialStateProperty.resolveWith((states) {
        return TextStyle(color: myPrimaryColor);
      }),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.resolveWith((states) {
        return TextStyle(color: myPrimaryColor);
      }),
      iconColor: MaterialStateProperty.resolveWith((states) {
        return myPrimaryColor;
      }),
    ),
  ),
);

var darkThemeData = ThemeData(
  primaryColor: const Color(0xFFBF9000),
  useMaterial3: true,
  brightness: Brightness.dark,
  indicatorColor: myPrimaryColorDark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  cardTheme: CardTheme(
    elevation: 8,
    shadowColor: myPrimaryColorDark,
    surfaceTintColor: myPrimaryColorDark,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: myPrimaryColorDark)),
  ),
  drawerTheme: DrawerThemeData(surfaceTintColor: myPrimaryColorDark),
  popupMenuTheme: PopupMenuThemeData(surfaceTintColor: myPrimaryColorDark),
  dialogTheme: DialogTheme(surfaceTintColor: myPrimaryColorDark),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      surfaceTintColor: MaterialStateProperty.resolveWith((states) {
        return myPrimaryColorDark;
      }),
      textStyle: MaterialStateProperty.resolveWith((states) {
        return TextStyle(color: myPrimaryColorDark);
      }),
    ),
  ),
);
