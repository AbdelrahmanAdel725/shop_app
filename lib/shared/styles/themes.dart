import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors
import 'package:flutter/services.dart';
import 'package:flutter_projects/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: 'Janna',
    ),
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 32.0,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.black,
    ),
    color: Colors.black,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.white,
    backgroundColor: Colors.black,
    type: BottomNavigationBarType.fixed,
  ),
);
ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: 'Janna',

    ),
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 32.0,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
    color: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.black,
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
  ),
);