import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

var lightTheme = ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600)),
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark),
        elevation: 0.0,
        backgroundColor: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Colors.orange),
    ));
var darkTheme = ThemeData(
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: HexColor('333739'),
            statusBarBrightness: Brightness.light),
        elevation: 0.0,
        backgroundColor: HexColor('333739')),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      elevation: 20,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      backgroundColor: HexColor('333739'),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Colors.orange),
    ));
