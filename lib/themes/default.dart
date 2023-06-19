import 'package:flutter/material.dart';
import 'package:test_app_talatix/config/config.dart';

var kDefaultTheme = ThemeData(
  fontFamily: "Montserrat",
  primaryColor: Config.primaryColor,
  scaffoldBackgroundColor: Config.scaffoldBg,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Config.primaryColor,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    buttonColor: Config.primaryColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      padding: const EdgeInsets.symmetric(horizontal: 20),
    ),
  ),
);
