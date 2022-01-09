import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key key}) : super(key: key);
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;

  @override
  Widget build(BuildContext context) {
    // 18% from top
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(30.0),
              Image.asset(Images.kAppIcon, width: 100),
              verticalSpace(20.0),
              Text("Sign Up", style: textStyle24px500w),
              verticalSpace(20.0),
              input("Name as per Rera ID", important: true),
              verticalSpace(10.0),
              input("Primary Contact Person Name"),
              verticalSpace(10.0),
              input("Primary Mobile Number", showChildButton: true, childButtonText: "Get OTP"),
              verticalSpace(10.0),
              input("OTP", showChildButton: true, childButtonText: "Verify"),
              verticalSpace(10.0),
              input("Email", showChildButton: true, childButtonText: "Get OTP"),
              verticalSpace(10.0),
              input("OTP", showChildButton: true, childButtonText: "Verify"),
              verticalSpace(10.0),
              input("Relationship Manager"),
              verticalSpace(10.0),
              input("Permanent Account Number (PAN)", important: true),
              verticalSpace(10.0),
              input("RERA Registration ID"),
              verticalSpace(40.0),
              loginButton(context),
              verticalSpace(20.0),
            ],
          ),
        ),
      ),
    );
  }

  Container input(String helperText, {bool important: false, bool showChildButton: false, String childButtonText: ""}) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          horizontalSpace(10.0),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              // controller: widget.textEditingController ?? _controller,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "$helperText",
                hintStyle: subTextStyle,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {
                /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
              },
            ),
          ),
          if (important)
            Container(
              height: 5.0,
              width: 5.0,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.colorPrimary),
            ),
          if (showChildButton)
            Row(
              children: [
                Container(
                  height: 5.0,
                  width: 5.0,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.colorPrimary),
                ),
                horizontalSpace(15.0),
                PmlButton(
                  width: 95,
                  height: 36,
                  text: "$childButtonText",
                  color: AppColors.colorSecondary,
                  onTap: () {},
                ),
              ],
            ),
          if (!showChildButton) horizontalSpace(10.0),
        ],
      ),
    );
  }

  PmlButton loginButton(BuildContext context) {
    return PmlButton(
      width: Utility.screenWidth(context) * 0.58,
      height: 36,
      text: "Next",
      onTap: () {
        Navigator.pushNamed(context, Screens.kUploadDocumentScreen);
      },
    );
  }
}
