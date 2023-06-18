import 'package:get/get.dart';
import 'package:test_app_talatix/repositories/user_repository.dart';
import 'package:test_app_talatix/services/connectivity_service.dart';
import 'package:test_app_talatix/services/storage_service.dart';

import '../../_base_controller.dart';

class HomeController extends BaseController {

  final storage = Get.find<StorageService>();
  final connectivity = Get.find<ConnectivityService>();

  final repo = UserInfoRepository();


}
