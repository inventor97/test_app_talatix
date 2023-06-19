import 'package:flutter/material.dart';
import 'package:test_app_talatix/config/config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.title,
    required this.onTap,
    this.isFilled = true,
    this.isLoading = false,
    this.borderRadius,
    this.height = 45,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.backgroundColor,
    this.alignText = MainAxisAlignment.center,
    this.titleColor,
    this.titleFontSize = 14,
    this.isTitleBold = true,
    this.padding,
  }) : super(key: key);

  final String? title;
  final bool isFilled;
  final VoidCallback onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isLoading;
  final double? borderRadius;
  final double height;
  final double? width;
  final MainAxisAlignment alignText;
  final Color? titleColor;
  final Color? backgroundColor;
  final double titleFontSize;
  final bool isTitleBold;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? (isFilled ? Config.primaryColor : Colors.transparent),
          border: Border.all(color: backgroundColor?.withOpacity(0.7) ?? Config.primaryColor.withOpacity(0.7)),
          borderRadius: BorderRadius.circular(borderRadius ?? Config.borderRadius),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: alignText,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              suffixIcon ?? Container(),
              isLoading
                  ? SizedBox(
                      width: 25,
                      height: 25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                        child: CircularProgressIndicator(color: isFilled ? Colors.white : titleColor, strokeWidth: 1),
                      ),
                    )
                  : Container(),
              title != null
                  ? Flexible(
                      child: Text(
                        title!,
                        style: TextStyle(
                          color: isFilled ? Colors.white : titleColor ?? Config.primaryColor,
                          fontWeight: isTitleBold ? FontWeight.bold : FontWeight.normal,
                          fontSize: titleFontSize,
                        ),
                        maxLines: isLoading ? 1 : null,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(),
              prefixIcon ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}
