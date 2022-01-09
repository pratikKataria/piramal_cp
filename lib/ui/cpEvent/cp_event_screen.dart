import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piramal_channel_partner/res/AppColors.dart';
import 'package:piramal_channel_partner/res/Fonts.dart';
import 'package:piramal_channel_partner/res/Images.dart';
import 'package:piramal_channel_partner/utils/Utility.dart';
import 'package:piramal_channel_partner/widgets/pml_button.dart';

class CPEventScreen extends StatelessWidget {
  const CPEventScreen({Key key}) : super(key: key);
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
            Text("CP Events (1)", style: textStyle24px500w),
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
                          height: 130.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.kImgEventPlaceholder1),
                              fit: BoxFit.fill,
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Piramal Mahalaxmi CP Meet", style: textStyle24px500w),
                              verticalSpace(10.0),
                              Row(
                                children: [
                                  Image.asset(Images.kIconCpEventCalender, height: 16),
                                  horizontalSpace(10.0),
                                  Text("June 21th, 2021", style: textStyle14px500w),

                                  horizontalSpace(25.0),
                                  Image.asset(Images.kIconClock, height: 16),
                                  horizontalSpace(10.0),
                                  Text("6 pm", style: textStyle14px500w),
                                ],
                              ),

                              verticalSpace(20.0),
                              Row(
                                children: [
                                  PmlButton(
                                    height: 32.0,
                                    text: "Attend",
                                    color: AppColors.attendButtonColor,
                                    padding: EdgeInsets.symmetric(horizontal: 20.0,),
                                  ),
                                  horizontalSpace(10.0),
                                  PmlButton(
                                    height: 32.0,
                                    text: "Tentative",
                                    color: AppColors.tentativeButtonColor,
                                    padding: EdgeInsets.symmetric(horizontal: 20.0,),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        verticalSpace(10.0),
                      ],
                    ),
                  ),

                  Text("Previous Events", style: textStyle20px500w),
                  verticalSpace(10.0),

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
                          height: 130.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.kImgEventPlaceholder),
                                fit: BoxFit.fill,
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Revanta - Ravik Launch Event", style: textStyle24px500w),
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
