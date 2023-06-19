
import 'dart:async';

import 'package:get/get.dart';
import 'package:test_app_talatix/pages/_base_controller.dart';
import 'package:test_app_talatix/repositories/user_repository.dart';
import 'package:test_app_talatix/services/connectivity_service.dart';
import 'package:test_app_talatix/services/storage_service.dart';

class PostsController extends BaseController {
  final storage = Get.find<StorageService>();
  final connectivity = Get.find<ConnectivityService>();
  late StreamSubscription connectivitySubscription;

  final repo = UserInfoRepository();



}
