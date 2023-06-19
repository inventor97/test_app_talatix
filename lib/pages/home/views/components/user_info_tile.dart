import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_talatix/AppRoutes.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/models/user_info_model.dart';
import 'package:test_app_talatix/widgets/custom_container.dart';
import 'package:test_app_talatix/widgets/labled_text.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserInfoModel user;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () => Get.toNamed(AppRoutes.USER_DETAILED, arguments: user.toJson()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabeledText(title: "username".tr, value: user.username ?? "no_data".tr),
          LabeledText(title: "name".tr, value: user.name ?? "no_data".tr),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: LabeledText(
                  title: "phone".tr,
                  icon: Icons.phone_enabled_rounded,
                  value: user.phone ?? "no_data".tr,
                  isTitleCenter: false,
                ),
              ),
              Expanded(
                child: LabeledText(
                  title: "email".tr,
                  icon: Icons.mail_outline_rounded,
                  valueChild: Text(
                    user.email ?? "no_data".tr,
                    style: const TextStyle(color: Config.primaryColor, decoration: TextDecoration.underline),
                    textAlign: TextAlign.end,
                  ),
                  isContentRight2Left: false,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
