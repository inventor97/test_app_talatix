import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/widgets/custom_button.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({
    Key? key,
    required this.label,
    this.image,
    this.svg,
    this.icon,
    this.callback,
    this.callBackLabel,
    this.color,
    this.iconSize = 45,
    this.actionButtonWidth = 230,
    this.actionButtonHeight = 35,
  }) : super(key: key);

  final String label;
  final String? image;
  final String? svg;
  final IconData? icon;
  final VoidCallback? callback;
  final Color? color;
  final double iconSize;
  final double actionButtonWidth;
  final double actionButtonHeight;
  final String? callBackLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image != null
              ? Image.asset(image!, width: iconSize, color: color ?? Config.primaryColor)
              : svg != null
                  ? SvgPicture.asset(svg!, width: iconSize, color: color ?? Config.primaryColor)
                  : Icon(icon ?? Icons.signal_cellular_connected_no_internet_4_bar_rounded, size: iconSize, color: color ?? Config.primaryColor),
          Text(label, style: TextStyle(fontSize: 14, color: color ?? Config.primaryColor), textAlign: TextAlign.center),
          callback != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CustomButton(
                    title: callBackLabel ?? "try_again".tr,
                    onTap: callback!,
                    width: 230,
                    height: 35,
                    isFilled: false,
                    titleColor: color != null ? Config.primaryColor : Colors.white,
                    backgroundColor: color ?? Config.primaryColor,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
