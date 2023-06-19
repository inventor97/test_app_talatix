import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_app_talatix/config/config.dart';

class ShimmerComponent extends StatelessWidget {
  const ShimmerComponent({
    Key? key,
    required this.height,
    required this.width,
    this.isCircular = false,
    this.hasBorder = false,
    this.margin,
  }) : super(key: key);

  final double height;
  final double width;
  final bool isCircular;
  final bool hasBorder;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: margin,
        height: height,
        width: width,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isCircular ? null : BorderRadius.circular(Config.borderRadius - 5),
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          border: hasBorder ? Border.all(color: Colors.white, width: 2) : Border.all(color: Colors.transparent),
        ),
      ),
    );
  }
}
