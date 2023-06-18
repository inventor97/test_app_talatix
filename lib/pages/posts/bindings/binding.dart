import '../controllers/controller.dart';
import 'package:get/get.dart';

class PostsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostsController());
  }
}
