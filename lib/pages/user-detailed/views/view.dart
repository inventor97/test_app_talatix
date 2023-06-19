import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app_talatix/AppRoutes.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/helpers/helper.dart';
import 'package:test_app_talatix/models/user_details_model.dart';
import 'package:test_app_talatix/pages/user-detailed/controllers/controller.dart';
import 'package:test_app_talatix/widgets/InfoItem.dart';
import 'package:test_app_talatix/widgets/custom_container.dart';
import 'package:test_app_talatix/widgets/error_component.dart';
import 'package:test_app_talatix/widgets/labled_text.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailedPage extends GetView<UserDetailedController> {
  const UserDetailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.user.username!, style: const TextStyle(color: Config.primaryColor, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(controller.user.username!, style: const TextStyle(fontSize: 16)),
                    Text(controller.user.name!, style: const TextStyle(color: Config.grayTextColor)),
                  ],
                ),
              ),
              controller.user.address != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: InfoItem(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        title: "user_address_info".tr,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${controller.user.address?.suite}, ${controller.user.address?.street}, ${controller.user.address?.city}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: LabeledText(
                                    title: "zip_code",
                                    value: controller.user.address!.zipcode!,
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(text: controller.user.address!.zipcode!));
                                      Fluttertoast.showToast(
                                        msg: "copied_to_clipboard".tr,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                      );
                                    },
                                  ),
                                ),
                                (controller.user.address?.geo?.lat != null && controller.user.address?.geo?.lng != null)
                                    ? GestureDetector(
                                        onTap: () =>
                                            GeneralHelper.openNavigator(controller.user.address!.geo!.lat!, controller.user.address!.geo!.lng!),
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: const BoxDecoration(
                                            color: Config.primaryColor40,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Center(child: Icon(Icons.location_on_outlined, color: Config.primaryColor)),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              controller.user.company != null
                  ? InfoItem(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      title: "user_workplace_info".tr,
                      content: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabeledText(title: "company".tr, value: controller.user.company!.name!),
                            LabeledText(title: "position".tr, value: controller.user.company!.catchPhrase!),
                            LabeledText(title: "bs".tr, value: controller.user.company!.bs!),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              InfoItem(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                title: "user_contacts_info".tr,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: LabeledText(
                            title: "phone".tr,
                            value: controller.user.phone!,
                            onTap: () => launchUrl(Uri.parse("tel://${controller.user.phone}"), mode: LaunchMode.externalApplication),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => launchUrl(Uri.parse("tel://${controller.user.phone}"), mode: LaunchMode.externalApplication),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Config.primaryColor40,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(child: Icon(Icons.phone_enabled_outlined, color: Config.primaryColor, size: 20)),
                          ),
                        )
                      ],
                    ),
                    LabeledText(
                      title: "website".tr,
                      value: controller.user.website!,
                      onTap: () => launchUrl(Uri.parse("https://${controller.user.website}"), mode: LaunchMode.externalApplication),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: LabeledText(
                            title: "email".tr,
                            valueChild: GestureDetector(
                              onTap: () => launchUrl(Uri.parse("mailto://${controller.user.email}"), mode: LaunchMode.externalApplication),
                              child: Text(
                                controller.user.email ?? "no_data".tr,
                                style: const TextStyle(color: Config.primaryColor, decoration: TextDecoration.underline),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => launchUrl(Uri.parse("mailto://${controller.user.email}"), mode: LaunchMode.externalApplication),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Config.primaryColor40,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(child: Icon(Icons.mail_outline_rounded, color: Config.primaryColor, size: 20)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: Text("user_albums_info".tr, style: const TextStyle(color: Config.primaryColor, fontSize: 16.0)),
              ),
              Obx(
                () => controller.storage.usersAlbums.list?.value != null ||
                        (List.from(controller.storage.usersAlbums.list!.value.where((item) => item.userId == controller.userId)).isNotEmpty) ||
                        controller.isUserAlbumsLoading.value
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if ((List.from(controller.storage.usersAlbums.list!.value.where((item) => item.userId == controller.userId)).isEmpty) ||
                                  controller.isUserAlbumsLoading.value) {
                                return Shimmer.fromColors(
                                  baseColor: Config.shimmerColor,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                                    width: double.infinity,
                                    height: 40,
                                    color: Config.shimmerContainersColor,
                                  ),
                                );
                              } else {
                                final album = List<UserAlbumsModel>.from(
                                    controller.storage.usersAlbums.list!.where((item) => item.userId == controller.userId))[index];
                                return CustomContainer(
                                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Center(
                                    child: Text(album.title ?? "no_data".tr),
                                  ),
                                );
                              }
                            },
                            itemCount: 3,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.ALBUMS, arguments: {
                                "username": controller.user.username,
                                "user_id": controller.user.id,
                                "albums": List<UserAlbumsModel>.from(
                                    controller.storage.usersAlbums.list!.where((item) => item.userId == controller.userId)),
                              }),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("more".tr, style: const TextStyle(color: Config.grayTextColor)),
                                    const Icon(Icons.chevron_right_outlined, color: Config.grayTextColor),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: controller.connectivity.isConnect.value
                            ? ErrorComponent(
                                label: "not_found".tr,
                                icon: Icons.playlist_remove_outlined,
                              )
                            : ErrorComponent(
                                label: "connection_error".tr,
                                callback: controller.syncUsersAlbums,
                              ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                child: Text("user_posts_info".tr, style: const TextStyle(color: Config.primaryColor, fontSize: 16.0)),
              ),
              Obx(
                () => controller.storage.usersPosts.list?.value != null ||
                        (List.from(controller.storage.usersPosts.list!.value.where((item) => item.userId == controller.userId)).isNotEmpty) ||
                        controller.isUserPostsLoading.value
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (controller.isUserPostsLoading.value) {
                                return Shimmer.fromColors(
                                  baseColor: Config.shimmerColor,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                                    width: double.infinity,
                                    height: 40,
                                    color: Config.shimmerContainersColor,
                                  ),
                                );
                              } else {
                                final post = List<UserPostsModel>.from(
                                    controller.storage.usersPosts.list!.where((item) => item.userId == controller.userId))[index];
                                return CustomContainer(
                                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(post.title ?? "no_data".tr, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 3.0),
                                      Flexible(child: Text(post.body ?? "no_data".tr)),
                                    ],
                                  ),
                                );
                              }
                            },
                            itemCount: 3,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.POSTS),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("more".tr, style: const TextStyle(color: Config.grayTextColor)),
                                    const Icon(Icons.chevron_right_outlined, color: Config.grayTextColor),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: controller.connectivity.isConnect.value
                            ? ErrorComponent(
                                label: "not_found".tr,
                                icon: Icons.playlist_remove_outlined,
                              )
                            : ErrorComponent(
                                label: "connection_error".tr,
                                callback: controller.syncUsersPosts,
                              ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
