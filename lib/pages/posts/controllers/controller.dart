import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_app_talatix/helpers/helper.dart';
import 'package:test_app_talatix/models/user_details_model.dart';
import 'package:test_app_talatix/pages/_base_controller.dart';
import 'package:test_app_talatix/repositories/user_repository.dart';
import 'package:test_app_talatix/services/connectivity_service.dart';
import 'package:test_app_talatix/services/storage_service.dart';

class PostsController extends BaseController {
  final storage = Get.find<StorageService>();
  final connectivity = Get.find<ConnectivityService>();
  late StreamSubscription connectivitySubscription;

  final repo = UserInfoRepository();

  RefreshController refreshController = RefreshController(initialRefresh: false);

  late String username;
  late int userId;
  late List<UserPostsModel> posts;

  @override
  void onInit() {
    super.onInit();

    username = Get.arguments['username'];
    userId = Get.arguments['user_id'];
    posts = Get.arguments['posts'];
  }

  void refreshUsersPosts() async {
    if (isLoading.value) return;

    if (!connectivity.isConnect.value) {
      GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      return;
    }

    try {
      isLoading.value = true;

      storage.usersPosts.list?.removeWhere((element) => element.userId == userId);
      storage.usersPosts.addAll(await repo.getUserPosts(userId));
      refreshController.refreshCompleted();
    } catch (e) {
      Logger().e(e);
      if (e.toString().contains("host") || e.toString().contains("connection")) {
        GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      }
      refreshController.refreshFailed();
    } finally {
      isLoading.value = false;
    }
  }
}
