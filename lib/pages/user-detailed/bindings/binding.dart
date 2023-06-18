import '../controllers/controller.dart';
import 'package:get/get.dart';

class UserDetailedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserDetailedController());
  }
}
