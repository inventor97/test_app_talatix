import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app_talatix/helpers/helper.dart';
import 'package:test_app_talatix/models/user_details_model.dart';
import 'package:test_app_talatix/models/user_info_model.dart';
import 'package:test_app_talatix/pages/_base_controller.dart';
import 'package:test_app_talatix/repositories/user_repository.dart';
import 'package:test_app_talatix/services/connectivity_service.dart';
import 'package:test_app_talatix/services/storage_service.dart';

class UserDetailedController extends BaseController {
  final storage = Get.find<StorageService>();
  final connectivity = Get.find<ConnectivityService>();
  late StreamSubscription connectivitySubscription;

  final repo = UserInfoRepository();

  late UserInfoModel user;
  late int userId;

  final isUserPostsLoading = false.obs;
  final isUserAlbumsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    user = UserInfoModel.fromJson(Get.arguments);
    userId = user.id!;

    _sync();

    connectivitySubscription = connectivity.isConnect.listen((value) {
      if (value) {
        _sync();
      }
    });
  }

  @override
  void onClose() {
    _sync();
    super.onClose();
  }

  void _sync() {
    syncUsersAlbums();
    syncUsersPosts();
  }

  void syncUsersPosts() async {
    if (isUserPostsLoading.value) return;

    if (storage.usersPosts.list != null && (List<UserPostsModel>.from(storage.usersPosts.list!.where((item) => item.userId == userId)).isNotEmpty)) {
      return;
    }

    if (!connectivity.isConnect.value) {
      GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      return;
    }

    try {
      isUserPostsLoading.value = true;

      storage.usersPosts.store = await repo.getUserPosts(userId);
    } catch (e) {
      Logger().e(e);
      if (e.toString().contains("host") || e.toString().contains("connection")) {
        GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      }
    } finally {
      isUserPostsLoading.value = false;
    }
  }

  void syncUsersAlbums() async {
    if (isUserAlbumsLoading.value) return;

    if (storage.usersAlbums.list != null &&
        (List.from(storage.usersAlbums.list!.where((item) => item.userId == userId)).isNotEmpty)) {
      return;
    }

    if (!connectivity.isConnect.value) {
      GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      return;
    }

    try {
      isUserAlbumsLoading.value = true;

      storage.usersAlbums.store = await repo.getUserAlbums(userId);
    } catch (e) {
      Logger().e(e);
      if (e.toString().contains("host") || e.toString().contains("connection")) {
        GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      }
    } finally {
      isUserAlbumsLoading.value = false;
    }
  }
}
