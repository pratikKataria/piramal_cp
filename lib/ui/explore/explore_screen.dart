import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key key}) : super(key: key);
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
            Text("Explore", style: textStyle24px500w),
            verticalSpace(33.0),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 18.0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: [
                        BoxShadow(
                          // box-shadow: 0px 10px 30px 0px #0000000D;
                          color: AppColors.colorSecondary.withOpacity(0.1),
                          blurRadius: 20.0,
                          spreadRadius: 5.0,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 151.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.kImgPlaceholder1),
                              fit: BoxFit.fill,
                            )
                          ),
                        ),
                        verticalSpace(10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Marketing Intelligence", style: textStyle24px500w),
                              Image.asset(Images.kIconicIntelligence, height: 24.0),
                            ],
                          ),
                        ),
                        verticalSpace(10.0),
                      ],
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(bottom: 18.0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: [
                        BoxShadow(
                          // box-shadow: 0px 10px 30px 0px #0000000D;
                          color: AppColors.colorSecondary.withOpacity(0.1),
                          blurRadius: 20.0,
                          spreadRadius: 5.0,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 151.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.kImgPlaceholder1),
                                fit: BoxFit.fill,
                              )
                          ),
                        ),
                        verticalSpace(10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("E-Learning", style: textStyle24px500w),
                              Image.asset(Images.kIconicIntelligence, height: 24.0),
                            ],
                          ),
                        ),
                        verticalSpace(10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
