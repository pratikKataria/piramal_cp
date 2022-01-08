import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class PersistentSideNavigation extends StatelessWidget {
  const PersistentSideNavigation({Key key}) : super(key: key);
  final textStyle = textStyleRegular18pxW500;
  final iconSize = 20.0;
  final iconPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          Text("Login to view your profile.", style: textStyle20px500w),
          verticalSpace(15.0),
          PmlButton(
            text: "Log In",
            width: 50.0,
            height: 36.0,
            margin: EdgeInsets.only(right: Utility.screenWidth(context) * 0.65),
          ),
          verticalSpace(40.0),

          //Home
          line(),
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconHome, width: iconSize),
              horizontalSpace(iconPadding),
              Text("Home", style: textStyle),
            ],
          ),
          verticalSpace(20.0),
          line(),

          //Projects
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconProjects, width: iconSize),
              horizontalSpace(iconPadding),
              Text("Projects", style: textStyle),
            ],
          ),
          verticalSpace(20.0),
          line(),

          //Current Promotions
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconCurrentPromotion, width: iconSize),
              horizontalSpace(iconPadding),
              Text("Current Promotions", style: textStyle),
            ],
          ),
          verticalSpace(20.0),
          line(),

          //View/Add Leads
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconLeads, width: iconSize),
              horizontalSpace(iconPadding),
              Text("View/Add Leads", style: textStyle),
            ],
          ),
          verticalSpace(20.0),
          line(),

          //CP Events
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconCpEvents, width: iconSize),
              horizontalSpace(iconPadding),
              Text("CP Events", style: textStyle),
            ],
          ),
          verticalSpace(20.0),
          line(),

          //My Assists
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconAssist, width: iconSize),
              horizontalSpace(iconPadding),
              Text("My Assists", style: textStyle),
            ],
          ),
          verticalSpace(20.0),
          line(),

          //Settings
          verticalSpace(20.0),
          Row(
            children: [
              Image.asset(Images.kIconSetting, width: iconSize),
              horizontalSpace(iconPadding),
              Text("Settings", style: textStyle),
            ],
          ),
          verticalSpace(20.0),
          line(),
        ],
      ),
    );
  }
}
