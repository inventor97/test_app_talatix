import '../controllers/controller.dart';
import 'package:get/get.dart';

class AlbumsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AlbumsController());
  }
}
