import '../controllers/controller.dart';
import 'package:get/get.dart';

class CommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CommentsController());
  }
}
