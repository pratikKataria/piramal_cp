import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/generated/assets.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class LeftChatWidget extends StatelessWidget {
  final String name;
  final String chatText;

  const LeftChatWidget({Key key, this.name, this.chatText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Utility.screenWidth(context) * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.colorSecondary,

            // image: DecorationImage(
            //   image: AssetImage(Images.kIconChatLeft),
            //   fit: BoxFit.fill,
            // ),
          ),
          child: Text(
            "$chatText",
            style: textStyleWhite12px500w,
          ),
        ),
        Row(
          children: [
            horizontalSpace(20.0),
            Image.asset(Assets.imagesIcDown, width: 35.0, color: AppColors.colorSecondary),
          ],
        ),
        verticalSpace(10.0),

        // verticalSpace(4.0),
        // Text(
        //   "$name",
        //   style: textStyle12px500w,
        // )
      ],
    );
  }
}
