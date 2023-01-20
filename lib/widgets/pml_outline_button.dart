import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';

class PmlOutlineButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextStyle textStyle;
  final Color color;
  final Color fillColor;
  final double height;
  final double width;

  const PmlOutlineButton({
    this.onTap,
    this.text,
    this.width,
    this.padding,
    this.margin,
    this.textStyle,
    this.color,
    this.fillColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 54.0,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: fillColor?? Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: AppColors.colorSecondary, width: 1.5),
        ),
        child: Center(
          child: Text(
            '$text',
            style: textStyle ?? textStyle14px500w,
          ),
        ),
      ),
    );
  }
}
