import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/widgets/custom_container.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    Key? key,
    this.title,
    this.content,
    this.titleChild,
    this.padding,
    this.isExpandable = true,
    this.onTap,
    this.backgroundColor,
    this.margin,
    this.parentPadding,
    this.isShadowEnable = true,
    this.isBottomModelDismissible = true,
    this.isBottomModelScrollable = false,
    this.expandableController,
    this.style,
    this.iconColor,
    this.width,
    this.constraints,
    this.titleColor,
    this.border,
    this.borderRadius,
  }) : super(key: key);

  final String? title;
  final Widget? titleChild;
  final TextStyle? style;
  final Widget? content;
  final bool isExpandable;
  final bool isBottomModelDismissible;
  final bool isBottomModelScrollable;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final Border? border;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? parentPadding;
  final bool isShadowEnable;
  final double? width;
  final double? borderRadius;
  final ExpandableController? expandableController;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 600),
      child: ScaleAnimation(
        scale: 0.4,
        child: FadeInAnimation(
          child: CustomContainer(
            margin: margin,
            width: width,
            constraints: constraints,
            padding: parentPadding,
            backgroundColor: backgroundColor,
            isShadowEnable: isShadowEnable,
            border: border,
            borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius!) : BorderRadius.circular(Config.borderRadius),
            child: isExpandable
                ? ExpandableNotifier(
                    child: ScrollOnExpand(
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          iconPadding: const EdgeInsets.all(0.0),
                          headerAlignment: ExpandablePanelHeaderAlignment.center,
                          iconSize: titleChild != null ? 0.0 : 24.0,
                          iconColor: iconColor ?? Config.primaryColor,
                          useInkWell: true,
                        ),
                        header: titleChild ??
                            Text(title ?? "",
                                style: style ?? TextStyle(color: titleColor ?? Config.primaryColor, fontSize: 13, fontWeight: FontWeight.bold)),
                        expanded: Padding(
                          padding: padding ?? const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: content,
                        ),
                        collapsed: Container(),
                        controller: expandableController,
                      ),
                    ),
                  )
                : GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onTap ??
                        () {
                          showModalBottomSheet(
                            context: Get.context!,
                            isDismissible: isBottomModelDismissible,
                            isScrollControlled: isBottomModelScrollable,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                child: content,
                              );
                            },
                          );
                        },
                    child: titleChild ??
                        Text(title ?? "", style: const TextStyle(color: Config.primaryColor, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
          ),
        ),
      ),
    );
  }
}
