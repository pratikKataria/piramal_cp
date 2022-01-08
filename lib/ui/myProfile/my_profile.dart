import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key key}) : super(key: key);
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
              Text("My Profile", style: textStyle24px500w),
              verticalSpace(33.0),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Container(
                      height: 46,
                      width: 46,
                      child: Image.asset(Images.kImgPlaceholder, fit: BoxFit.fill),
                    ),
                  ),
                  horizontalSpace(14.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mr. Sunil Pant", style: textStyle20px500w),
                      Text("RERA ID 123456789", style: textStyleSubText14px500w),
                    ],
                  ),
                  Spacer(),
                  PmlButton(
                    height: 32.0,
                    width: 32.0,
                    child: Icon(Icons.edit, color: AppColors.white, size: 16),
                  )
                ],
              ),
              verticalSpace(30.0),
              buildProfileDetailCard("Primary Contact Person", "Raghav Anand"),
              buildProfileDetailCard("Primary Mobile Number", "+91 87239 48782"),
              buildProfileDetailCard("Secondary Mobile Number", "+91 47661 48872"),
              buildProfileDetailCard("Primary Email ID", "sunilpant@piramal.com"),
              buildProfileDetailCard("Permanent Account Number (PAN)", "9378-4982-9381-2938"),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Click on", style: textStyleSubText16px500w),
                  horizontalSpace(6.0),
                  PmlButton(
                    height: 24.0,
                    width: 24.0,
                    child: Icon(Icons.edit, color: AppColors.white, size: 12.0),
                  ),
                  horizontalSpace(6.0),
                  Text("to upload pending documents", style: textStyleSubText16px500w),
                ],
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
}
