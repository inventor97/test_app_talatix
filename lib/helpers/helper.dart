import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralHelper {

  static showAlertMessage(String title, String message, {bool isSuccessMessage = true}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isSuccessMessage ? Config.primaryColor : Config.errorColor.withOpacity(0.8),
      titleText: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
    );
  }

  static void openNavigator(String lat, String long) async {
    try {
      if (!await launchUrl(
        Uri.parse("yandexnavi://build_route_on_map?lat_to=$lat&lon_to=$long"),
        mode: LaunchMode.externalApplication,
      )) {
        final url = Uri.parse(
          Platform.isAndroid ? "market://details?id=${Config.yandexNavigatorAppId}" : "https://apps.apple.com/app/id${Config.yandexNavigatorIOSAppId}",
        );
        launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } on PlatformException catch (e) {
      final url = Uri.parse(
        Platform.isAndroid ? "market://details?id=${Config.yandexNavigatorAppId}" : "https://apps.apple.com/app/id${Config.yandexNavigatorIOSAppId}",
      );
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

}