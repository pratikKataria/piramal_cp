import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';

class PmlButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextStyle textStyle;
  final Color color;
  final double height;
  final double width;
  final double radius;
  final Widget child;

  const PmlButton({
    this.onTap,
    this.text,
    this.padding,
    this.margin,
    this.textStyle,
    this.color,
    this.child,
    this.height,
    this.width,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 44.0,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? AppColors.colorPrimary,
          borderRadius: BorderRadius.circular(radius ?? 80.0),
        ),
        child: child ??
            Center(
              child: Text(
                '$text',
                style: textStyle ?? textStyleWhite16px500w,
              ),
            ),
      ),
    );
  }
}
