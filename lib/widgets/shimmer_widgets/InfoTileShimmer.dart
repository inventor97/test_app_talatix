import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app_talatix/config/config.dart';

class InfoTileShimmer extends StatelessWidget {
  const InfoTileShimmer({
    Key? key,
    this.width,
    this.height = 120,
  }) : super(key: key);

  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final color = Config.shimmerContainersColor;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Shimmer.fromColors(
        baseColor: Config.shimmerColor,
        highlightColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          width: width ?? double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Config.borderRadius),
            color: color,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 15,
                width: Get.size.width - 82,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Config.borderRadius),
                  color: color,
                ),
              ),
              Container(
                height: 15,
                width: Get.size.width - 82,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Config.borderRadius),
                  color: color,
                ),
              ),
              Container(
                height: 15,
                width: Get.size.width - 82,
                padding: const EdgeInsets.only(left: 15, right: 35),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Config.borderRadius),
                  color: color,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 15,
                        width: 100,
                        padding: const EdgeInsets.only(left: 15, right: 35),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Config.borderRadius),
                          color: color,
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 100,
                        padding: const EdgeInsets.only(left: 15, right: 35),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Config.borderRadius),
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
