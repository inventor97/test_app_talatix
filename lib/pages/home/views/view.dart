import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/helpers/pull_to_refresh_classic_header.dart';
import 'package:test_app_talatix/pages/home/views/components/search_user_delegate.dart';
import 'package:test_app_talatix/pages/home/views/components/user_info_tile.dart';
import 'package:test_app_talatix/widgets/error_component.dart';
import 'package:test_app_talatix/widgets/shimmer_widgets/info_tile_shimmer.dart';
import '../controllers/controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test_app".tr, style: const TextStyle(color: Config.primaryColor, fontWeight: FontWeight.bold)),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/image/logo.png"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchUsersDelegate(controller.storage.users.list?.value ?? []));
            },
            icon: const Icon(Icons.search_outlined, color: Config.primaryColor),
          )
        ],
      ),
      body: Obx(
        () => (controller.storage.users.list?.isNotEmpty ?? false) || controller.isLoading.value
            ? SmartRefresher(
                enablePullDown: !controller.isLoading.value && (controller.storage.users.list?.isNotEmpty ?? false),
                onRefresh: () => controller.syncUsers(isRefreshing: true),
                controller: controller.refreshController,
                header: PullToRefreshClassicHeader(),
                physics: controller.isLoading.value ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  itemBuilder: (context, index) {
                    if (controller.isLoading.value) {
                      return const InfoTileShimmer();
                    } else {
                      final user = controller.storage.users.list![index];
                      return UserInfoTile(user: user);
                    }
                  },
                  shrinkWrap: true,
                  itemCount: controller.storage.users.list?.length,
                ),
              )
            : Center(
                child: controller.connectivity.isConnect.value
                    ? ErrorComponent(
                        label: "not_found".tr,
                        icon: Icons.playlist_remove_outlined,
                      )
                    : ErrorComponent(
                        label: "connection_error".tr,
                        callback: controller.syncUsers,
                      ),
              ),
      ),
    );
  }
}
