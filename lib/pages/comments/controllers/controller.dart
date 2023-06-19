import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_app_talatix/helpers/helper.dart';
import 'package:test_app_talatix/models/user_details_model.dart';
import 'package:test_app_talatix/pages/_base_controller.dart';
import 'package:test_app_talatix/repositories/user_repository.dart';
import 'package:test_app_talatix/services/connectivity_service.dart';
import 'package:test_app_talatix/services/storage_service.dart';

class CommentsController extends BaseController {
  final storage = Get.find<StorageService>();
  final connectivity = Get.find<ConnectivityService>();
  late StreamSubscription connectivitySubscription;

  final repo = UserInfoRepository();

  late String username;
  late int userId;
  late UserPostsModel post;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  final formKey = GlobalKey<FormState>();
  final commenterNameTxtCtrl = TextEditingController();
  final commentTxtCtrl = TextEditingController();
  final commenterEmailNameTxtCtrl = TextEditingController();

  final isCommentSending = false.obs;

  @override
  void onInit() {
    super.onInit();

    username = Get.arguments['username'];
    userId = Get.arguments['user_id'];
    post = UserPostsModel.fromJson(Get.arguments['post']);

    syncComments();

    connectivitySubscription = connectivity.isConnect.listen((value) {
      if (value) {
        syncComments();
      }
    });
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
    super.onClose();
  }

  void syncComments({bool isRefreshing = false}) async {
    if (isLoading.value) return;

    if (!connectivity.isConnect.value) {
      GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      return;
    }

    if ((storage.comments[userId]?[post.id!]?.isNotEmpty ?? false) && !isRefreshing) return;

    try {
      isLoading.value = true;

      if (isRefreshing) storage.comments[userId]?[post.id!]?.clear();

      if (storage.comments[userId] == null) storage.comments[userId] = {};

      storage.comments[userId]![post.id!] = await repo.getComments(post.id!);
      if (isRefreshing) refreshController.refreshCompleted();
    } catch (e) {
      Logger().e(e);
      if (e.toString().contains("host") || e.toString().contains("connection")) {
        GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      }
      if (isRefreshing) refreshController.refreshFailed();
    } finally {
      isLoading.value = false;
    }
  }

  void sendComment() async {
    if (isCommentSending.value) return;

    if (!connectivity.isConnect.value) {
      GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      return;
    }

    try {
      isCommentSending.value = true;
      final addedComment = await repo.sendComment(commenterNameTxtCtrl.text, commentTxtCtrl.text, commenterEmailNameTxtCtrl.text, post.id!);
      storage.comments[userId]?[post.id]?.add(addedComment);
      clearInputs();
      Get.back();
      GeneralHelper.showAlertMessage("success".tr, "successfully_commented".tr);
    } catch (e) {
      Logger().e(e);
      if (e.toString().contains("host") || e.toString().contains("connection")) {
        GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      }
    } finally {
      isCommentSending.value = false;
    }
  }

  void clearInputs() {
    commenterNameTxtCtrl.text = "";
    commentTxtCtrl.text = "";
    commenterEmailNameTxtCtrl.text = "";
  }
}
