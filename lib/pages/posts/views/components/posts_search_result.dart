import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_talatix/AppRoutes.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/models/user_details_model.dart';
import 'package:test_app_talatix/models/user_info_model.dart';
import 'package:test_app_talatix/pages/home/views/components/user_info_tile.dart';
import 'package:test_app_talatix/pages/posts/controllers/controller.dart';
import 'package:test_app_talatix/widgets/InfoItem.dart';

class PostsSearchResult extends GetView<PostsController> {
  const PostsSearchResult({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final List<UserPostsModel> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: posts.length,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      itemBuilder: (context, index) {
        final post = posts[index];
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
      },
    );
  }
}
