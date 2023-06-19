import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/helpers/pull_to_refresh_classic_header.dart';
import 'package:test_app_talatix/widgets/error_component.dart';
import 'package:test_app_talatix/widgets/shimmer_widgets/shimmer_component.dart';
import '../controllers/controller.dart';

class AlbumsPage extends GetView<AlbumsController> {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.username, style: const TextStyle(fontWeight: FontWeight.bold, color: Config.primaryColor, fontSize: 16.0)),
            Text("albums".tr, style: const TextStyle(color: Config.primaryColor, fontSize: 12)),
          ],
        ),
        centerTitle: false,
      ),
      body: Obx(
        () => SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: !controller.isLoading.value && (controller.storage.photos[controller.userId]?.isNotEmpty ?? false),
          onRefresh: controller.refreshUsersAlbums,
          header: PullToRefreshClassicHeader(),
          physics: controller.isLoading.value ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
          child: controller.isLoading.value
              ? const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Config.primaryColor,
                      strokeWidth: 1.5,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.albums.length,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemBuilder: (context, index) {
                    final album = controller.albums[index];
                    return album.title != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0, right: 35.0),
                                  child: Text(album.title!,
                                      style: const TextStyle(color: Config.primaryColor, fontWeight: FontWeight.bold, fontSize: 13)),
                                ),
                                Obx(
                                  () => album.isLoading!.value
                                      ? Center(
                                          child: Container(
                                            width: 30,
                                            height: 120,
                                            padding: const EdgeInsets.symmetric(vertical: 45.0),
                                            child: const CircularProgressIndicator(
                                              color: Config.primaryColor,
                                              strokeWidth: 1.5,
                                            ),
                                          ),
                                        )
                                      : ((controller.storage.photos[controller.userId]?[album.id!]?.isNotEmpty ?? false))
                                          ? SizedBox(
                                              height: 120,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                itemCount: controller.storage.photos[controller.userId]?[album.id!]?.length,
                                                itemBuilder: (context, index) {
                                                  final photo = controller.storage.photos[controller.userId]?[album.id!]?[index];
                                                  return Padding(
                                                    padding: const EdgeInsets.only(top: 7.0, right: 10.0, bottom: 10.0),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(Config.borderRadius),
                                                      child: Stack(
                                                        alignment: Alignment.bottomCenter,
                                                        children: [
                                                          SizedBox(
                                                            width: 200,
                                                            height: 110,
                                                            child: CachedNetworkImage(
                                                              imageUrl: photo!.url!,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context, _) => const ShimmerComponent(height: 110, width: 230),
                                                              errorWidget: (builder, url, error) {
                                                                Logger().e(error.toString());
                                                                return Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 75,
                                                                      child: Image.asset("assets/image/logo.png", color: Config.grayTextColor),
                                                                    ),
                                                                    const SizedBox(height: 10.0),
                                                                    Text(
                                                                      "unknown_error_on_load_image".tr,
                                                                      style: const TextStyle(color: Config.grayTextColor),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius.circular(Config.borderRadius),
                                                                bottomRight: Radius.circular(Config.borderRadius),
                                                              ),
                                                              color: Colors.white,
                                                            ),
                                                            padding: const EdgeInsets.all(5.0),
                                                            child: Align(
                                                              alignment: Alignment.bottomLeft,
                                                              child: Text(
                                                                photo.title ?? "no_data".tr,
                                                                maxLines: 2,
                                                                style: const TextStyle(fontSize: 12),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Center(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                child: controller.connectivity.isConnect.value
                                                    ? ErrorComponent(
                                                        label: "not_found".tr,
                                                        icon: Icons.playlist_remove_outlined,
                                                      )
                                                    : ErrorComponent(
                                                        label: "connection_error".tr,
                                                        callback: () => controller.getPhotosOfAlbum(album),
                                                      ),
                                              ),
                                            ),
                                ),
                              ],
                            ),
                          )
                        : Container();
                  },
                ),
        ),
      ),
    );
  }
}
