import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/enums/HttpMethods.dart';
import 'package:test_app_talatix/services/storage_service.dart';

class BaseRepository {
  final StorageService storage = Get.find();

  String buildUrl(String url) {
    return "${Config.domain}$url";
  }

  Future makeHttpRequest(
      String url,
      body, {
        bool withAuth = false,
        HttpMethodTypes method = HttpMethodTypes.GET,
        autoRefreshToken = true,
        Map<String, String>? headers,
        bool isFormData = false,
        Map<String, dynamic>? files,
        bool isPureUrl = false,
        bool isAbsoluteUrl = false,
      }) async {
    try {
      if (headers == null) {
        String type = (isFormData) ? 'application/x-www-form-urlencoded' : 'application/json';
        headers = {'Content-Type': '$type; charset=utf-8'};
      }

      if (!isPureUrl) {
        headers.addAll({
          'Accept': 'application/json',
          'Accept-Language' : storage.lang.data?.value
        });

        url = (isAbsoluteUrl) ? url : buildUrl(url);
      }

      //If jwt token available
      // if (withAuth) headers['Authorization'] = "Bearer ${storage.activeToken.data?.value}";

      var req;
      late http.Response response;
      if (files != null) {
        req = http.MultipartRequest(method.value, Uri.parse(url))..followRedirects = false;
        req.fields.addAll(body);
        for (String key in files.keys) {
          if (files[key] != "" && files[key] != null) req.files.add(await http.MultipartFile.fromPath(key, files[key].toString()));
        }
      } else {
        req = http.Request(method.value, Uri.parse(url))..followRedirects = false;

        if ([HttpMethodTypes.POST, HttpMethodTypes.PUT].contains(method)) {
          req.body = (isFormData) ? Uri(queryParameters: body).query : req.body = jsonEncode(body);
        }
      }
      req.headers.addAll(headers);

      http.StreamedResponse stream = await req.send();
      response = await http.Response.fromStream(stream);

      Logger().d("HTTP: ${response.statusCode.toString()}, URL: $url, body:$body files: $files");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}