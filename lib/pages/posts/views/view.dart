import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app_talatix/AppRoutes.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/helpers/pull_to_refresh_classic_header.dart';
import 'package:test_app_talatix/pages/posts/views/components/search_posts_delegate.dart';
import 'package:test_app_talatix/widgets/InfoItem.dart';
import 'package:test_app_talatix/widgets/custom_container.dart';
import 'package:test_app_talatix/widgets/error_component.dart';
import '../controllers/controller.dart';

class PostsPage extends GetView<PostsController> {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.username, style: const TextStyle(fontWeight: FontWeight.bold, color: Config.primaryColor, fontSize: 16.0)),
            Text("posts".tr, style: const TextStyle(color: Config.primaryColor, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchPostsDelegate(controller.storage.usersPosts.list?.value ?? []));
            },
            icon: const Icon(Icons.search_outlined, color: Config.primaryColor),
          )
        ],
        centerTitle: false,
      ),
      body: Obx(
        () => controller.isLoading.value || (controller.storage.usersPosts.list?.isNotEmpty ?? false)
            ? SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: !controller.isLoading.value && (controller.storage.usersPosts.list?.isNotEmpty ?? false),
                onRefresh: controller.refreshUsersPosts,
                header: PullToRefreshClassicHeader(),
                physics: controller.isLoading.value ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemCount: List.from(controller.storage.usersPosts.list!.where((element) => element.userId == controller.userId)).length,
                  physics: controller.isLoading.value ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (controller.isLoading.value) {
                      return CustomContainer(
                        child: Shimmer.fromColors(
                          baseColor: Config.shimmerColor,
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(color: Config.shimmerContainersColor, borderRadius: BorderRadius.circular(Config.borderRadius)),
                          ),
                        ),
                      );
                    } else {
                      final post = List.from(controller.storage.usersPosts.list!.where((element) => element.userId == controller.userId))[index];
                      return InfoItem(
                        title: post.title,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(child: Text(post.body ?? "no_data".tr)),
                            GestureDetector(
                              onTap: () => Get.toNamed(
                                AppRoutes.COMMENTS,
                                arguments: {
                                  "post": post.toJson(),
                                  "user_id": controller.userId,
                                  "username": controller.username,
                                },
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "comments".tr,
                                      style: const TextStyle(color: Config.primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                    const Icon(Icons.chevron_right_outlined, color: Config.primaryColor),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
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
                        callback: controller.refreshUsersPosts,
                      ),
              ),
      ),
    );
  }
}
