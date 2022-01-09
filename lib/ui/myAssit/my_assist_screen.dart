import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class MyAssistScreen extends StatelessWidget {
  const MyAssistScreen({Key key}) : super(key: key);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(22.0),
            Text("My Assist", style: textStyle24px500w),
            verticalSpace(33.0),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80.0),
                        child: Container(
                          height: 46,
                          width: 46,
                          padding: EdgeInsets.all(10.0),
                          color: AppColors.assistIconBackgroundColor,
                          child: Image.asset(Images.kIconicAssistPerson),
                        ),
                      ),
                      horizontalSpace(14.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Abhinav Jaitly", style: textStyle20px500w),
                          Text("Relationship Manager", style: textStyleSubText14px500w),
                        ],
                      ),
                      Spacer(),
                      PmlButton(
                        height: 32.0,
                        width: 32.0,
                        color: AppColors.colorPrimaryLight,
                        padding: EdgeInsets.all(10.0),
                        child: Image.asset(Images.kIconPhone),
                      ),
                      horizontalSpace(10.0),
                      PmlButton(
                        height: 32.0,
                        width: 32.0,
                        color: AppColors.colorPrimaryLight,
                        child: Image.asset(Images.kIconWhatsApp),
                      ),
                    ],
                  ),
                  verticalSpace(24.0),
                  line(),
                  verticalSpace(24.0),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80.0),
                        child: Container(
                          height: 46,
                          width: 46,
                          padding: EdgeInsets.all(10.0),
                          color: AppColors.assistIconBackgroundColor,
                          child: Image.asset(Images.kIconicAssistPerson),
                        ),
                      ),
                      horizontalSpace(14.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rishi Jaiswal", style: textStyle20px500w),
                          Text("Head of Department (HOD)", style: textStyleSubText14px500w),
                        ],
                      ),
                      Spacer(),
                      PmlButton(
                        height: 32.0,
                        width: 32.0,
                        color: AppColors.colorPrimaryLight,
                        padding: EdgeInsets.all(10.0),
                        child: Image.asset(Images.kIconPhone),
                      ),
                      horizontalSpace(10.0),
                      PmlButton(
                        height: 32.0,
                        width: 32.0,
                        color: AppColors.colorPrimaryLight,
                        child: Image.asset(Images.kIconWhatsApp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: PmlButton(
                width: Utility.screenWidth(context) * 0.55,
                text: "Raise Query",
              ),
            ),
            verticalSpace(50.0),
          ],
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
}
