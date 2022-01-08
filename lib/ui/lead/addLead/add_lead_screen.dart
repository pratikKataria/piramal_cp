import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class AddLeadScreen extends StatelessWidget {
  const AddLeadScreen({Key key}) : super(key: key);
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  @override
  Widget build(BuildContext context) {
    // 18% from top
    final perTop18 = Utility.screenHeight(context) * 0.18;
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(22.0),
              Text("Add Lead", style: textStyle24px500w),
              verticalSpace(20.0),
              buildProfileDetailCard("Name of the Customer", "Raghav Anand"),
              buildProfileDetailCard("Mobile Number", "+91 87239 48782"),
              buildProfileDetailCard2("Interested In", "Piramal Mahalaxmi"),
              buildProfileDetailCard2("Configuration", "2 Bedroom"),
              buildProfileDetailCard2("Budget", "INR 5 Crore "),
              buildProfileDetailCard2("Location", "Navi Mumbai"),
              buildProfileDetailCard2("Date of Visit", "27 October 2021"),

              Center(
                child: PmlButton(
                  width: Utility.screenWidth(context) * 0.55,
                  text: "Submit",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildProfileDetailCard(String mText, String sText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "$mText",
            style: textStyle14px500w,
          ),
          Text("$sText", style: textStyleSubText14px500w),
        ],
      ),
    );
  }

  Container buildProfileDetailCard2(String mText, String sText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: EdgeInsets.only(bottom: 18.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "$mText",
            style: textStyle14px500w,
          ),
          Text("$sText", style: textStyleSubText14px500w),
        ],
      ),
    );
  }
}
