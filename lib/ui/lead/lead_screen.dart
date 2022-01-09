import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/res/Screens.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class LeadScreen extends StatelessWidget {
  const LeadScreen({Key key}) : super(key: key);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Leads", style: textStyle24px500w),
                PmlButton(
                  height: 28.0,
                  text: "Add Lead",
                  color: AppColors.colorSecondary,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  onTap: () {
                    Navigator.pushNamed(context, Screens.kAddLeadScreen);
                  },
                )
              ],
            ),
            verticalSpace(33.0),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 150,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                                Text("+91 28309 48200", style: textStyleSubText14px500w),
                              ],
                            ),
                            Spacer(),
                            PmlButton(
                              height: 32.0,
                              width: 32.0,
                              color: AppColors.screenBackgroundColor,
                              child: Icon(Icons.edit, size: 16),
                            ),
                            horizontalSpace(10.0),
                            PmlButton(
                              height: 32.0,
                              width: 32.0,
                              color: AppColors.colorPrimaryLight,
                              child: Icon(Icons.delete, color: AppColors.colorPrimary, size: 16),
                            ),
                          ],
                        ),
                        line(),
                        Container(
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColors.chipColor,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                child: Text("Piramal Aranya", style: textStyle14px500w),
                              ),
                              horizontalSpace(10.0),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColors.chipColor,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                child: Text("Piramal Mahalaxmi", style: textStyle14px500w),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                                Text("+91 28309 48200", style: textStyleSubText14px500w),
                              ],
                            ),
                            Spacer(),
                            PmlButton(
                              height: 32.0,
                              width: 32.0,
                              color: AppColors.screenBackgroundColor,
                              child: Icon(Icons.edit, size: 16),
                            ),
                            horizontalSpace(10.0),
                            PmlButton(
                              height: 32.0,
                              width: 32.0,
                              color: AppColors.colorPrimaryLight,
                              child: Icon(Icons.delete, color: AppColors.colorPrimary, size: 16),
                            ),
                          ],
                        ),
                        line(),
                        Container(
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColors.chipColor,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                child: Text("Piramal Aranya", style: textStyle14px500w),
                              ),
                              horizontalSpace(10.0),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColors.chipColor,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                child: Text("Piramal Mahalaxmi", style: textStyle14px500w),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                                Text("+91 28309 48200", style: textStyleSubText14px500w),
                              ],
                            ),
                            Spacer(),
                            PmlButton(
                              height: 32.0,
                              width: 32.0,
                              color: AppColors.screenBackgroundColor,
                              child: Icon(Icons.edit, size: 16),
                            ),
                            horizontalSpace(10.0),
                            PmlButton(
                              height: 32.0,
                              width: 32.0,
                              color: AppColors.colorPrimaryLight,
                              child: Icon(Icons.delete, color: AppColors.colorPrimary, size: 16),
                            ),
                          ],
                        ),
                        line(),
                        Container(
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColors.chipColor,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                child: Text("Piramal Aranya", style: textStyle14px500w),
                              ),
                              horizontalSpace(10.0),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColors.chipColor,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                child: Text("Piramal Mahalaxmi", style: textStyle14px500w),
                              ),
                            ],
                          ),
                        ),
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
