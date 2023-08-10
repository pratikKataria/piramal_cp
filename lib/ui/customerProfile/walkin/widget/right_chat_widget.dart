import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/generated/assets.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class RightChatWidget extends StatelessWidget {
  final String c;

  const RightChatWidget(this.c, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: Utility.screenWidth(context) * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.colorPrimary,
            // image: DecorationImage(
            // image: AssetImage(Images.kIconChatRight),
            // fit: BoxFit.fill,
            // ),
          ),
          child: Text(
            "$c",
            style: textStyleWhite12px500w,
          ),
        ),
        Row(
          children: [
            Spacer(),
            Image.asset(Assets.imagesIcDown, width: 35.0, color: AppColors.colorPrimary),
            horizontalSpace(20.0),
          ],
        ),
        verticalSpace(10.0),
        // Text(
        //   "Suhail Patel (Cp)",
        //   style: textStylePrimary12px500w,
        // )
      ],
    );
  }
}
