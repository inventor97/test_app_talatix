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

class AlbumsController extends BaseController {
  final storage = Get.find<StorageService>();
  final connectivity = Get.find<ConnectivityService>();
  late StreamSubscription connectivitySubscription;

  final repo = UserInfoRepository();

  RefreshController refreshController = RefreshController(initialRefresh: false);

  late String username;
  late List<UserAlbumsModel> albums;
  late int userId;

  @override
  void onInit() {
    super.onInit();

    username = Get.arguments['username'];
    albums = Get.arguments['albums'];
    userId = Get.arguments['user_id'];

    _sync();

    connectivitySubscription = connectivity.isConnect.listen((connection) {
      if (connection) {
        _sync();
      }
    });
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
    super.onClose();
  }

  void _sync() async {
    try {
      for (UserAlbumsModel album in albums) {
        await getPhotosOfAlbum(album);
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void refreshUsersAlbums() async {
    if (isLoading.value) return;

    if (!connectivity.isConnect.value) {
      GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      return;
    }

    try {
      isLoading.value = true;

      storage.usersAlbums.list?.removeWhere((element) => element.userId == userId);
      storage.usersAlbums.addAll(await repo.getUserAlbums(userId));
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

  Future<void> getPhotosOfAlbum(UserAlbumsModel album) async {
    if (album.isLoading!.value) return;

    if (!connectivity.isConnect.value) {
      GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      return;
    }

    if (storage.photos[userId]?[album.id]?.isNotEmpty ?? false) return;

    try {
      album.isLoading!.value = true;
      if (storage.photos[userId] == null) storage.photos[userId] = {};
      storage.photos[userId]![album.id!] = await repo.getPhotos(album.id!);
    } catch (e) {
      Logger().e(e);
      if (e.toString().contains("host") || e.toString().contains("connection")) {
        GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      }
      throw ("Error");
    } finally {
      album.isLoading!.value = false;
    }
  }
}
