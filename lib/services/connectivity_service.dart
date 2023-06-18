import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ConnectivityService extends GetxService {
  late StreamSubscription subscription;
  final isConnect = true.obs;

  @override
  onInit() async {
    super.onInit();
    final connectivityResult = await (Connectivity().checkConnectivity());
    (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile)
        ? isConnect.value = true
        : isConnect.value = false;
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        // Get.snackbar(
        //   backgroundColor: Config.blueColor.withOpacity(0.8),
        //   colorText: Colors.white,
        //   messageText: Text("offline_mode".tr, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        // );
        isConnect.value = false;
        Logger().i("$result is_connect = ${isConnect.value}");
      } else if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        if (!isConnect.value) {
          // Get.snackbar(
          //   titleText: nclean 7ull,
          //   backgroundColor: Config.greenColor,
          //   messageText: Text("connected".tr, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          // );
        }
        isConnect.value = true;
        Logger().i("$result is_connect = ${isConnect.value}");
      }
    });
  }

  @override
  onClose() {
    super.onClose();
    subscription.cancel();
  }
}
