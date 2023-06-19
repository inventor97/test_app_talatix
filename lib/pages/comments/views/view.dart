import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/helpers/helper.dart';
import 'package:test_app_talatix/helpers/pull_to_refresh_classic_header.dart';
import 'package:test_app_talatix/widgets/custom_button.dart';
import 'package:test_app_talatix/widgets/custom_container.dart';
import 'package:test_app_talatix/widgets/custom_input.dart';
import 'package:test_app_talatix/widgets/error_component.dart';
import 'package:test_app_talatix/widgets/labled_text.dart';
import 'package:test_app_talatix/widgets/shimmer_widgets/info_tile_shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/controller.dart';

class CommentsPage extends GetView<CommentsController> {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.username, style: const TextStyle(fontWeight: FontWeight.bold, color: Config.primaryColor, fontSize: 16.0)),
            Text("comments".tr, style: const TextStyle(color: Config.primaryColor, fontSize: 12)),
          ],
        ),
        centerTitle: false,
      ),
      body: Obx(
        () => SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: !controller.isLoading.value && (controller.storage.comments[controller.userId]?[controller.post.id!]?.isNotEmpty ?? false),
          onRefresh: () => controller.syncComments(isRefreshing: true),
          header: PullToRefreshClassicHeader(),
          physics: controller.isLoading.value ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.post.title ?? "no_data".tr,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Config.primaryColor)),
                      Text(controller.post.body ?? "no_data".tr),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                  child: Text("comments".tr, style: const TextStyle(color: Config.primaryColor)),
                ),
                (controller.storage.comments[controller.userId]?[controller.post.id!]?.isNotEmpty ?? false) || controller.isLoading.value
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.isLoading.value ? 10 : controller.storage.comments[controller.userId]?[controller.post.id!]?.length,
                        itemBuilder: (context, index) {
                          if (controller.isLoading.value) {
                            return const InfoTileShimmer();
                          } else {
                            final comment = controller.storage.comments[controller.userId]?[controller.post.id!]?[index];
                            return comment != null
                                ? CustomContainer(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        LabeledText(title: "name".tr, value: comment.name ?? "no_data".tr, isTitleCenter: false),
                                        const SizedBox(height: 5.0),
                                        Text(comment.body ?? "no_data".tr),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () => launchUrl(Uri.parse("mailto:${comment.email}"), mode: LaunchMode.externalApplication),
                                            child: Text(
                                              comment.email ?? "no_data".tr,
                                              style: const TextStyle(color: Config.primaryColor, fontSize: 12, decoration: TextDecoration.underline),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container();
                          }
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: controller.connectivity.isConnect.value
                              ? ErrorComponent(
                                  label: "not_found".tr,
                                  icon: Icons.playlist_remove_outlined,
                                )
                              : ErrorComponent(
                                  label: "connection_error".tr,
                                  callback: controller.syncComments,
                                ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Config.borderRadius),
            ),
          ),
          isScrollControlled: true,
          builder: (builder) => Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Config.borderRadius),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("write_comment".tr),
                    const SizedBox(height: 15.0),
                    CustomInput(
                      controller: controller.commenterNameTxtCtrl,
                      validator: GeneralHelper.inputValidator,
                      labelText: "name".tr,
                      keyboardType: TextInputType.name,
                    ),
                    CustomInput(
                      controller: controller.commentTxtCtrl,
                      validator: GeneralHelper.inputValidator,
                      labelText: "comment".tr,
                      maxLines: 8,
                      keyboardType: TextInputType.text,
                    ),
                    CustomInput(
                      controller: controller.commenterEmailNameTxtCtrl,
                      validator: GeneralHelper.inputValidator,
                      labelText: "email".tr,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20.0),
                    Obx(
                      () => CustomButton(
                        width: double.infinity,
                        onTap: controller.sendComment,
                        title: "send".tr,
                        isLoading: controller.isCommentSending.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ).then(
          (value) => controller.clearInputs(),
        ),
        backgroundColor: Config.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
