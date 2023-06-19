import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_app_talatix/config/config.dart';

class LabeledText extends StatelessWidget {
  final String title;
  final String value;
  final Widget? valueChild;
  final bool isContentRight2Left;
  final bool isTitleCenter;
  final CrossAxisAlignment? verticalAlignment;
  final IconData? icon;
  final String? png;
  final String? svg;
  final String? networkImage;
  final TextStyle? titleStyle;
  final double? iconSize;
  final double titleFontSize;
  final Color? iconColor;
  final int? valueTextMaxLines;
  final VoidCallback? onTap;

  const LabeledText({
    Key? key,
    required this.title,
    this.value = '',
    this.valueChild,
    this.isContentRight2Left = true,
    this.isTitleCenter = true,
    this.icon,
    this.png,
    this.svg,
    this.networkImage,
    this.iconSize,
    this.titleStyle,
    this.titleFontSize = 12,
    this.valueTextMaxLines,
    this.iconColor,
    this.onTap,
    this.verticalAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: isContentRight2Left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: isContentRight2Left ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: verticalAlignment ?? CrossAxisAlignment.center,
            children: [
              networkImage != null
                  ? networkImage!.endsWith(".svg")
                      ? Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: SvgPicture.network(networkImage!, width: iconSize, height: iconSize, color: iconColor ?? Config.grayTextColor),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Image.network(networkImage!, width: iconSize, height: iconSize, color: iconColor ?? Config.grayTextColor),
                        )
                  : svg != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: SvgPicture.asset(svg!, width: iconSize, height: iconSize, color: iconColor ?? Config.grayTextColor),
                        )
                      : png != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Image.asset(png!, width: iconSize),
                            )
                          : icon != null
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Icon(icon, size: iconSize ?? 18, color: iconColor ?? Config.grayTextColor),
                                )
                              : Container(),
              Flexible(
                child: Text(
                  title,
                  style: titleStyle ?? TextStyle(color: Config.grayTextColor, fontSize: titleFontSize),
                  textAlign: isContentRight2Left ? TextAlign.left : TextAlign.right,
                ),
              ),
            ],
          ),
          valueChild ??
              InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: isContentRight2Left ? MainAxisAlignment.start : MainAxisAlignment.end,
                  crossAxisAlignment: isContentRight2Left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: isTitleCenter ? TextAlign.center : isContentRight2Left ?  TextAlign.start : TextAlign.end,
                        maxLines: valueTextMaxLines,
                      ),
                    ),
                  ],
                ),
              ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
