import 'package:flutter/material.dart';
import 'package:test_app_talatix/models/models.dart';

class Config {
  static const Color primaryColor = Color(0xFF0068E0);
  static const Color primaryColor40 = Color(0xFFB2D2F6);
  static const Color secondaryColor = Color(0xFFFC4B6F);
  static const Color errorColor = Color(0xFFE77171);
  static const Color grayTextColor = Color(0xFF939393);
  static const Color scaffoldBg = Color(0xFFF1FAFF);

  static const Color shimmerColor = Colors.grey;
  static Color shimmerContainersColor = Colors.white.withOpacity(0.2);

  static const containerShadows = [
    BoxShadow(
      color: Color(0x11000000),
      offset: Offset(0, 0),
      blurRadius: 10,
    ),
  ];

  static List<LanguageModel> languages = [
    LanguageModel(langValue: "en", label: "Enlish", shortLabel: "Eng"),
    LanguageModel(langValue: "ru", label: "Русский", shortLabel: "Рус"),
  ];

  //strings
  static const String domain = 'https://jsonplaceholder.typicode.com/';
  static const String yandexNavigatorAppId = "ru.yandex.yandexnavi";
  static const String yandexNavigatorIOSAppId = "474500851";


  //constant values
  static const double borderRadius = 10;
}
