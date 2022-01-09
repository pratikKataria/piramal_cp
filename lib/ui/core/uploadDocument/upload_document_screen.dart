import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/ui/base/provider/base_provider.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';
import 'package:provider/provider.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({Key key}) : super(key: key);

  @override
  _UploadDocumentScreenState createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  final subTextStyle = textStyleSubText14px500w;
  final mainTextStyle = textStyle14px500w;
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    // 18% from top
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(Images.kAppIcon, width: 100),
                  Text("Sign Up", style: textStyle20px500w),
                ],
              ),
              verticalSpace(20.0),
              buildProfileDetailCard("Type of Firm", "Partnership Firm"),
              buildProfileDetailCard2("RERA Certificate", "28377_43434.pdf"),
              buildProfileDetailCard2("PAN Card", "PAN_589_3948.pdf"),
              buildProfileDetailCard2("List of Directors", "DirectorsList_2021.pdf"),
              buildProfileDetailCard2("Partnership Deed", "PD2020_V2.pdf"),
              buildProfileDetailCard2("List of Partners", "LOP2021_5.pdf"),
              verticalSpace(15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue;
                      });
                    },
                  ),
                  Text("I Agree to the Terms & Conditions", style: textStyle14px500w),
                ],
              ),
              verticalSpace(15.0),
              loginButton(context),
              verticalSpace(15.0),
            ],
          ),
        ),
      ),
    );
  }

  Container buildProfileDetailCard(String mText, String sText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColors.screenBackgroundColor,
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
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColors.screenBackgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$mText", style: textStyle14px500w),
              Text("$sText", style: textStyleSubText14px500w),
            ],
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.colorPrimary,
            ),
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              Images.kIconUpload,
            ),
          ),
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
        var provider = Provider.of<BaseProvider>(context, listen: false);
        provider.showToolTip();
        Navigator.pushNamed(context, Screens.kHomeBase);
      },
    );
  }
}
