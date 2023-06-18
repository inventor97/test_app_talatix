import 'package:get/get.dart';
import 'package:test_app_talatix/services/connectivity_service.dart';
import 'package:test_app_talatix/services/storage_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityService());
    Get.put(StorageService());
  }
}
