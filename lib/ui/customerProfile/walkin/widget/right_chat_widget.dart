import 'package:flutter/material.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              image: AssetImage(Images.kIconChatRight),
              fit: BoxFit.fill,
            ),
          ),
          child: Text(
            "$c",
            style: textStyleWhite12px500w,
          ),
        ),
        verticalSpace(4.0),
        Text(
          "Suhail Patel (Cp)",
          style: textStylePrimary12px500w,
        )
      ],
    );
  }
}
