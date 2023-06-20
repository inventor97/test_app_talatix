import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_talatix/i18n/en_EN.dart';
import 'package:test_app_talatix/i18n/ru_RU.dart';

class Messages extends Translations {
  static get defaultLang => const Locale('ru');

  @override
  Map<String, Map<String, String>> get keys => {
        "ru": ru_RU.translations,
        "en": en_EN.translations,
      };
}
