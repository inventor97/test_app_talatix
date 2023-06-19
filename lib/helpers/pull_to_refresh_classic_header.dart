import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

class PullToRefreshClassicHeader extends ClassicHeader {
  PullToRefreshClassicHeader({
    Key? key,
  }) : super(
          key: key,
          idleText: 'pull_idle'.tr,
          refreshingText: 'pull_refreshing'.tr,
          completeText: 'pull_complete'.tr,
          failedText: 'pull_failed'.tr,
          canTwoLevelText: 'pull_can_two_level'.tr,
          releaseText: 'pull_release'.tr,
          failedIcon: const Icon(Icons.clear, color: Colors.grey),
        );
}