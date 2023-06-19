import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_app_talatix/helpers/helper.dart';
import 'package:test_app_talatix/repositories/user_repository.dart';
import 'package:test_app_talatix/services/connectivity_service.dart';
import 'package:test_app_talatix/services/storage_service.dart';

import '../../_base_controller.dart';

class HomeController extends BaseController {
  final storage = Get.find<StorageService>();
  final connectivity = Get.find<ConnectivityService>();

  final repo = UserInfoRepository();

  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    syncUsers();
  }

  void syncUsers({bool isRefreshing = false}) async {
    if (isLoading.value) return;

    if ((storage.users.list?.isNotEmpty ?? false) && !isRefreshing) return;

    if (!connectivity.isConnect.value) {
      GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      return;
    }

    try {
      isLoading.value = true;

      if (isRefreshing) storage.users.list?.clear();
      storage.users.store = await repo.getUsers();
    } catch (e) {
      Logger().e(e);
      if (e.toString().contains("host") || e.toString().contains("connection")) {
        GeneralHelper.showAlertMessage("connection_error".tr, "sure_to_connect".tr, isSuccessMessage: false);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
