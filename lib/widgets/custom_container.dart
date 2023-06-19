import 'package:flutter/material.dart';
import 'package:test_app_talatix/config/config.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.backgroundColor,
    this.border,
    this.borderRadius,
    this.isShadowEnable = true,
    this.constraints,
    this.onTap,
  }) : super(key: key);

  final Color? backgroundColor;
  final bool isShadowEnable;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget child;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final BoxConstraints? constraints;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      constraints: constraints ?? const BoxConstraints(maxWidth: 450),
      duration: const Duration(milliseconds: 400),
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(15.0),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(Config.borderRadius),
        border: border,
        boxShadow: isShadowEnable ? Config.containerShadows : [],
      ),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: child,
      ),
    );
  }
}
