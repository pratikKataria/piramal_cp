import 'package:flutter/material.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              image: AssetImage(Images.kIconChatLeft),
              fit: BoxFit.fill,
            ),
          ),
          child: Text(
            "$chatText",
            style: textStyleWhite12px500w,
          ),
        ),
        verticalSpace(4.0),
        Text(
          "$name",
          style: textStyle12px500w,
        )
      ],
    );
  }
}
